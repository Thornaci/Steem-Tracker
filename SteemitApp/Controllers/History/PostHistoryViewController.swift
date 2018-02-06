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
    @IBOutlet weak var postContentLabel: UILabel!
    
    let nm = NetworkManager.init()
    let helper = Helpers.init()
    
    var postsHistory = [PostHistoryModel]()
    var filteredPostsHistory = [[PostHistoryModel]]()
    var hud: MBProgressHUD?
    var lastSelecttedButtonIndex = 101

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Post History"
        navigationController?.navigationBar.topItem?.title = ""
        setChartSettings()
        getPostData()
    }
    
    private func getPostData() {
        hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud?.detailsLabel.text = "Posts information are loading.."
        nm.getSteemitAccountPostHistory(username: username, success: { (postsHistoryData) in
            self.postsHistory = postsHistoryData
            self.filteredPostsHistory = self.helper.filterLastWeekData(postsHistory: postsHistoryData)
            self.setChartValues(index: 101)
            self.hud?.hide(animated: true)
        }) { (error) in
            self.hud?.hide(animated: true)
        }
    }
    
    //Tag 101 last week posts, 102 pending payouts button
    @IBAction func changeAction(_ sender: Any) {
        let button = sender as! UIButton
        lastSelecttedButtonIndex = button.tag
        setChartValues(index: button.tag)
    }
    
    private func setChartValues(index: Int) {
        var barChartDatas = [BarChartDataEntry]()
        var i = 0
        var set1 = BarChartDataSet(values: barChartDatas, label: "")
        switch index {
        case 101:
            var totalPostCount = 0
            for filteredPostsArray in filteredPostsHistory {
                let val = BarChartDataEntry.init(x: Double(Date().dayOfYear - 7 + i), y: Double(filteredPostsArray.count))
                
                totalPostCount = totalPostCount + filteredPostsArray.count
                i += 1
                barChartDatas.append(val)
            }
            postContentLabel.text = "\(username) posted \(totalPostCount) post last week"
            set1 = BarChartDataSet(values: barChartDatas, label: "Last 7 Days")
            break
        case 102:
            var totalPendingPayouts: Double = 0
            for filteredPostsArray in filteredPostsHistory {
                var pendingPayouts: Double = 0
                for filteredPostArray in filteredPostsArray {
                    pendingPayouts = pendingPayouts + filteredPostArray.pendingPayoutValueDouble
                }
                totalPendingPayouts = totalPendingPayouts + pendingPayouts
                let val = BarChartDataEntry.init(x: Double(Date().dayOfYear - 7 + i), y: pendingPayouts)
                
                i += 1
                barChartDatas.append(val)
            }
            postContentLabel.text = "\(username)'s posts total pending payouts = \(totalPendingPayouts)"
            set1 = BarChartDataSet(values: barChartDatas, label: "Pending Payouts")
            break
        default:
            break
        }

        set1.colors = ChartColorTemplates.material()
        let data = BarChartData(dataSet: set1)
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
        data.barWidth = 0.9
        chartView.data = data
        chartView.animate(yAxisDuration: 2)
    }
    
    private func setChartSettings() {
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.granularity = 1
        xAxis.labelCount = 7
        xAxis.valueFormatter = DayAxisValueFormatter(chart: chartView)
        
        chartView.delegate = self
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = true
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = false
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let day = sender as! Int
        let index = Date().dayOfYear - day
        let phcVC = segue.destination as! PostHistoryContentsViewController
        phcVC.contentArray = filteredPostsHistory[filteredPostsHistory.count - index - 1]
        phcVC.day = day
        switch lastSelecttedButtonIndex {
        case 101:
            phcVC.category = "Post Contents"
            break
        case 102:
            phcVC.category = "Pending Payouts"
            break
        default:
            break
        }
    }
}

extension PostHistoryViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        performSegue(withIdentifier: "showContent", sender: highlight.x)
    }
}
