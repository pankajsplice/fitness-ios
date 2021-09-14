//
//  BloodPressureDetailVC.swift
//  GoMove
//


import UIKit
import Charts

final class BloodPressureDetailVC: BaseViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet private weak var weekDatesLbl: UILabel!
    @IBOutlet private weak var previousWeekAction: ActionButton!
    @IBOutlet private weak var nextWeekAction: ActionButton!
    
    //MARK:- Variable Declarations
    let players = ["S", "M", "T", "W", "T", "F", "S"]
    let goals = [600, 300, 400, 200, 658, 1000, 550]
    
    //Dates
    var weekEndDate = Date()
    var weekStartDate = Date()
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBtnAction()
        customizeChart(dataPoints: players, values: goals.map{ Double($0) })
        let completeDate = setDatesForSevenDays(weekLastDate: Date().startOfDay)
        weekDatesLbl.text = "\(completeDate.0) - \(completeDate.1)"
    }
    
    //MARK:- Helper methods
    func customizeChart(dataPoints: [String], values: [Double]) {
      // TO-DO: customize the chart here
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
          let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
          dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.backgroundColor = .clear
        barChartView.isUserInteractionEnabled = false
        chartDataSet.colors = [#colorLiteral(red: 0.9734235406, green: 0, blue: 0.418574214, alpha: 1)]
        chartDataSet.drawValuesEnabled = false
        chartData.barWidth = Double(0.35)
        barChartView.data = chartData
        chartDataSet.barGradientColors = [[#colorLiteral(red: 0.1882352941, green: 0.1254901961, blue: 0.3137254902, alpha: 1),#colorLiteral(red: 0.7147975564, green: 0.02773489617, blue: 0.337511003, alpha: 1)]]
        
        let formatter: ChartFormatter = ChartFormatter()
        formatter.setValues(values: dataPoints)
        //Axes setup
        let xaxis:XAxis = XAxis()
        xaxis.valueFormatter = formatter
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelTextColor = .white
        barChartView.xAxis.axisLineColor = .clear
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.drawGridBackgroundEnabled = false
        barChartView.drawValueAboveBarEnabled = false
        barChartView.drawBordersEnabled = false
        barChartView.xAxis.valueFormatter = xaxis.valueFormatter
        barChartView.chartDescription.enabled = false
        barChartView.legend.enabled = false
        barChartView.rightAxis.enabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.drawLabelsEnabled = false
        barChartView.leftAxis.drawAxisLineEnabled = false
        barChartView.leftAxis.drawTopYLabelEntryEnabled = false
        barChartView.chartDescription.enabled = false
        barChartView.data = chartData
        barChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInBounce)

    }
    
    //Setup Date range
    private func setDatesForSevenDays(weekLastDate: Date) -> (String,String) {
        weekEndDate = weekLastDate
        weekStartDate = weekEndDate.add(component: .day, value: -6)
        let weekEndDateValue = DateUtils.getStringFromDateNew(date: weekEndDate)
        let weekStartDateValue = DateUtils.getStringFromDateNew(date: weekStartDate)
        return (weekStartDateValue,weekEndDateValue)
    }
    
    //MARK:- UIButton action methods
    
    //MARK:- UIButton action methods
    private func setupBtnAction() {

        previousWeekAction.touchUp = { button in
            let completeDate = self.setDatesForSevenDays(weekLastDate: self.weekStartDate.add(component: .day, value: -1))
            self.weekDatesLbl.text = "\(completeDate.0) - \(completeDate.1)"
        }
        
        nextWeekAction.touchUp = { button in
            if self.weekEndDate != Date().startOfDay {
                let completeDate = self.setDatesForSevenDays(weekLastDate: self.weekEndDate.add(component: .day, value: 7))
                self.weekDatesLbl.text = "\(completeDate.0) - \(completeDate.1)"
            }
        }
    }

}
