////
////  BarChart.swift
////  Hi Health
////
////  Created by k2 tam on 26/07/2023.
////
//
//import UIKit
//import Charts
//
//
//class CustomAxisValueFormatter: IndexAxisValueFormatter {
//    var month: Int
//
//        init(month: Int) {
//            self.month = month
//            super.init()
//        }
//    
//    // Implement the IAxisValueFormatter method to customize x-axis labels
//    override func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        // Cast the value to an Int since it represents the day in your example
//        let day = Int(value)
//        // Return the formatted date string
//        return "\(day)/\(month)"
//    }
//}
//
//class BarChart: UIViewController {
//    
//    struct ActiChartModel {
//        let distance: Double
//        let day: Int
//        let month: Int
//
//        init(from activity: Activity){
//            let dayMonth = activity.getDayMonth
//            
//            self.distance = activity.distance
//            self.day = dayMonth.day
//            self.month = dayMonth.month
//            
//        }
//    }
//    
//    var actiModels: [ActiChartModel] = []
//   
//    var activitiesList: [Activity] = [] {
//        didSet {
//            self.actiModels = activitiesList.map({ activity in
//                return ActiChartModel(from: activity)
//            })
//        }
//    }
//
//    @IBOutlet weak var barChartView: BarChartView!
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        
//        var dataEntries: [BarChartDataEntry] = []
//        for actiModel in actiModels {
//            let dataEntry = BarChartDataEntry(x: Double(actiModel.day), y: actiModel.distance/1000)
//            dataEntries.append(dataEntry)
//        }
//
//        
//        let dataSet = BarChartDataSet(entries: dataEntries)
//        let data = BarChartData(dataSet: dataSet)
//        barChartView.data = data
//        
//        
//        barChartView.notifyDataSetChanged()
//
//
//        
//        configChart(actiModels)
// 
//    }
//    func configChart(_ activites: [ActiChartModel]) {
//        // Disable scrolling in the chart
//        barChartView.dragEnabled = false
//        barChartView.setScaleEnabled(false)
//
//
//
//        // Adjust the Y-axis position
//        barChartView.leftAxis.enabled = false // Enable the right Y-axis
//        barChartView.leftAxis.drawLabelsEnabled = false // Hide labels on the right Y-axis
//        barChartView.xAxis.labelPosition = .bottom
//        
//        let xAxis = barChartView.xAxis
//        xAxis.setLabelCount(activites.count, force: false)
//        
//        // Create the CustomAxisValueFormatter with the month from the first activity
//        if let firstActivity = activites.first {
//            xAxis.valueFormatter = CustomAxisValueFormatter(month: firstActivity.month)
//        }
//
//    }
//}
