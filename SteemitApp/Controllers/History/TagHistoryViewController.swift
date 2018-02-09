//
//  TagHistoryViewController.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/30/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit
import Charts
import MBProgressHUD

class TagHistoryViewController: BaseViewController {

    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var tagLabel: ThoLabel!
    @IBOutlet weak var tagHistoryCountLabel: ThoLabel!
    
    let nm = NetworkManager.init()
    let helper = Helpers.init()
    
    var hud: MBProgressHUD?
    var tagsHistory = [TagHistoryModel]()
    var filteredTagsHistory = [TagHistoryModel]()
    var lastSelectedButtonIndex = 101
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChartSetting()
        getPostData()
        
        navigationItem.title = "Tag History"
        navigationController?.navigationBar.topItem?.title = ""
        
    }
    
    private func setChartSetting() {
        chartView.delegate = self
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = false
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = false
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false
        chartView.xAxis.labelTextColor = UIColor.barTintColor()
        chartView.leftAxis.labelTextColor = UIColor.barTintColor()
        chartView.rightAxis.labelTextColor = UIColor.barTintColor()
        chartView.legend.textColor = .white
    }
    
    private func getPostData() {
        hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud?.detailsLabel.text = "Tags are loading.."
        nm.getSteemitTagsHistory(success: { (tagsHistoryData) in
            
            if tagsHistoryData.count > 10 {
                self.tagsHistory = tagsHistoryData
                let button = self.view.viewWithTag(101) as! UIButton
                button.layer.borderColor = UIColor.init(white: 1, alpha: 0.5).cgColor
                self.setChartValues(index: 101)
            }
            self.hud?.hide(animated: true)
        }) { (error) in
            self.hud?.hide(animated: true)
        }
    }
    
    // 4 type categories. 101, 102, 103, 104.
    @IBAction func changeTag(_ sender: Any) {
        for index in 101...104 {
            let button = view.viewWithTag(index)
            button?.layer.borderColor = UIColor.navBarBorderColor().cgColor
        }
        let button = sender as! UIButton
        button.layer.borderColor = UIColor.init(white: 1, alpha: 0.5).cgColor
        lastSelectedButtonIndex = button.tag
        setChartValues(index: button.tag)
    }
    
    private func setChartValues(index: Int) {
        var barChartDatas = [BarChartDataEntry]()
        var i = 0
        var set1 = BarChartDataSet(values: barChartDatas, label: "")
        
        switch index {
        case 101:
            filteredTagsHistory = helper.findTopTenTagsForComment(tagsHistory: tagsHistory)
            for tagHistory in filteredTagsHistory {
                let val = BarChartDataEntry.init(x: Double(i), y: Double(tagHistory.comments))
                i += 1
                barChartDatas.append(val)
            }
            set1 = BarChartDataSet(values: barChartDatas, label: "Comment")
            break
        case 102:
            filteredTagsHistory = helper.findTopTenTagsForTotalPayouts(tagsHistory: tagsHistory)
            for tagHistory in filteredTagsHistory {
                let val = BarChartDataEntry.init(x: Double(i), y: tagHistory.totalPayoutsDouble)
                i += 1
                barChartDatas.append(val)
            }
            set1 = BarChartDataSet(values: barChartDatas, label: "Total Payouts SBD")
            break
        case 103:
            filteredTagsHistory = helper.findTopTenTagsForTopPosts(tagsHistory: tagsHistory)
            for tagHistory in filteredTagsHistory {
                let val = BarChartDataEntry.init(x: Double(i), y: Double(tagHistory.topPosts))
                i += 1
                barChartDatas.append(val)
            }
            set1 = BarChartDataSet(values: barChartDatas, label: "Top Posts")
            break
        case 104:
            filteredTagsHistory = helper.findTopTenTagsForNetVotes(tagsHistory: tagsHistory)
            for tagHistory in filteredTagsHistory {
                let val = BarChartDataEntry.init(x: Double(i), y: Double(tagHistory.netVotes))
                i += 1
                barChartDatas.append(val)
            }
            set1 = BarChartDataSet(values: barChartDatas, label: "Net Votes")
            break
        default:
            break
        }
        
        set1.setColor(UIColor.white)
        set1.colors = ChartColorTemplates.material()
        set1.drawValuesEnabled = false
        set1.valueTextColor = UIColor.white
        set1.highlightAlpha = 0
        
        let data = BarChartData(dataSet: set1)
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
        data.barWidth = 0.9
        data.setValueTextColor(UIColor.white)
        chartView.data = data
        chartView.animate(yAxisDuration: 2)
    }
}

extension TagHistoryViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let tagHistory = filteredTagsHistory[Int(highlight.x)]
        tagLabel.text = "TAG : " + tagHistory.name!
        switch lastSelectedButtonIndex {
        case 101:
            tagHistoryCountLabel.text = "Total Count : " + tagHistory.comments.description
            break
        case 102:
            tagHistoryCountLabel.text = "Total Count : " + tagHistory.totalPayouts!
            break
        case 103:
            tagHistoryCountLabel.text = "Total Count : " + tagHistory.topPosts.description
            break
        case 104:
            tagHistoryCountLabel.text = "Total Count : " + tagHistory.netVotes.description
            break
        default:
            break
        }
    }
}
