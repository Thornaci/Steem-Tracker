//
//  PostHistoryViewController.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 2/3/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit
import MBProgressHUD
import DateToolsSwift
import Charts

class PostHistoryViewController: BaseViewController {

    @IBOutlet weak var chartView: BarChartView!
    
    let nm = NetworkManager.init()
    let helper = Helpers.init()
    
    var postsHistory = [PostHistoryModel]()
    var filteredPostsHistory = [[PostHistoryModel]]()
    var hud: MBProgressHUD?

    override func viewDidLoad() {
        super.viewDidLoad()

        hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud?.detailsLabel.text = "Tags are loading.."
        nm.getSteemitAccountPostHistory(username: username, success: { (postsHistoryData) in
            self.postsHistory = postsHistoryData
            self.filteredPostsHistory = self.helper.filterLastWeekData(postsHistory: postsHistoryData)
            self.setChartValues()
            self.hud?.hide(animated: true)
        }) { (error) in
            self.hud?.hide(animated: true)
        }
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.granularity = 1
        xAxis.labelCount = 7
        xAxis.valueFormatter = DayAxisValueFormatter(chart: chartView)
        
        chartView.delegate = self
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = false
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = false
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false
    }
    
    private func setChartValues() {
        var barChartDatas = [BarChartDataEntry]()
        var i = 0

        for filteredPostsArray in filteredPostsHistory {
            
            let val = BarChartDataEntry.init(x: Double(Date().dayOfYear - 7 + i), y: Double(filteredPostsArray.count))

            i += 1
            barChartDatas.append(val)
        }
        
        var set1 = BarChartDataSet(values: barChartDatas, label: "Last 7 Days")
        
        set1.colors = ChartColorTemplates.material()
        set1.drawValuesEnabled = false
        
        let data = BarChartData(dataSet: set1)
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
        data.barWidth = 0.9
        chartView.data = data
        chartView.animate(yAxisDuration: 2)
    }
}

extension PostHistoryViewController: ChartViewDelegate {
    
}
