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
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var tagHistoryCountLabel: UILabel!
    
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
    }
    
    private func getPostData() {
        hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud?.detailsLabel.text = "Tags are loading.."
        nm.getSteemitTagsHistory(success: { (tagsHistoryData) in
            
            if tagsHistoryData.count > 10 {
                self.tagsHistory = tagsHistoryData
                self.setChartValues(index: 101)
            }
            self.hud?.hide(animated: true)
        }) { (error) in
            self.hud?.hide(animated: true)
        }
    }
    
    // 4 type categories. 101, 102, 103, 104.
    @IBAction func changeTag(_ sender: Any) {
        let button = sender as! UIButton
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
        
        set1.colors = ChartColorTemplates.material()
        set1.drawValuesEnabled = false
        
        let data = BarChartData(dataSet: set1)
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
        data.barWidth = 0.9
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
