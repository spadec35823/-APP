//
//  ChartViewController.swift
//  MyAPP
//
//  Created by user on 2020/6/17.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import Foundation
import Charts

class ChartViewController: UIViewController {
    
    @IBOutlet weak var showView: UIView!
    @IBOutlet weak var timeTitle: UILabel!
    var chartsHeight: Int = 500
    let spacesHeight: Int = 200
    let x: Int = 0
    var viewWidth: Int = 0
    
    
    var moodEntries: [BarChartDataEntry] = []
    var waterEntries: [BarChartDataEntry] = []
    var exerciseEntries: [ChartDataEntry] = []
    var categoryEntries: [PieChartDataEntry] = []
    var categoryDict: [Int : String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeTitle.text = gettimeStamp()
        viewWidth = Int(self.view.frame.width)
        chartsHeight = Int(self.view.frame.height) / 2 - 50
        
        if let path = Bundle.main.path(forResource: "Category", ofType: "plist"),
            let array = NSArray(contentsOfFile: path) {
            // Use your myDict here
            for case let category as NSDictionary in array {
                categoryDict[category.object(forKey: "code") as! Int] = category.object(forKey: "name") as? String
            }
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeMonth(value: 0)
    }
    
    @IBAction func previousMonth(_ sender: UIButton) {
        timeTitle.text = getLastMonth(nowDate: timeTitle.text!)
        changeMonth(value: -1)
    }
    
    @IBAction func nextMonth(_ sender: UIButton) {
        timeTitle.text = getNextMonth(nowDate: timeTitle.text!)
        changeMonth(value: 1)
    }
    
    func changeMonth(value: Int) {
        let eventCategoryDict = SQLiteManager.shareManger().chartsQueryData(date: timeTitle.text!)
        categoryEntries.removeAll()
        for n in eventCategoryDict.keys {
            var label = ""
            switch n {
            case "1":
                label = "美食"
                break
            case "2":
                label = "衣服"
                break
            case "3":
                label = "住宿"
                break
            case "4":
                label = "交通"
                break
            case "5":
                label = "玩樂"
                break
            default:
                label = "其他"
                break
            }
            categoryEntries.append(PieChartDataEntry(value: Double(eventCategoryDict[n]!), label: label))
        }
        
        drawCharts()
    }
    
    func drawCharts() {
        showView.subviews.forEach({$0.removeFromSuperview()})
        let eventCategoryChart = PieChartView(frame: CGRect(x: x, y: 100, width: viewWidth, height: chartsHeight))
        eventCategoryChart.noDataText = "沒有任何資料"
        if categoryEntries.count > 0 {
            eventCategoryChart.chartDescription?.text = ""
            
            let chartDataSet = PieChartDataSet(entries: categoryEntries, label: "")
            let chartData = PieChartData(dataSet: chartDataSet)
            
            var colors: [UIColor] = []
            for _ in 0..<categoryEntries.count {
                colors.append(UIColor.init(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0))
            }
            chartDataSet.colors = colors
            
            eventCategoryChart.data = chartData
        }
        showView.addSubview(eventCategoryChart)
    }
    
}
