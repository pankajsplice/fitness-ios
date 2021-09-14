//
//  SleepDetailVC.swift
//  GoMove
//


import UIKit
import Charts

final class SleepDetailVC: BaseViewController {

    //MARK:- IBOutlets
    @IBOutlet private weak var timeAsleepLbl: UILabel!
    @IBOutlet private weak var sleepPercentageLbl: UILabel!
    @IBOutlet private weak var heartRateLbl: UILabel!
    @IBOutlet private weak var sleepGoalBtn: ActionButton!
    @IBOutlet weak var barChartView: BarChartView!
    
    //MARK:- Variable Declarations
    let players = ["S", "M", "T", "W", "T", "F", "S"]
    let goals = [600, 300, 400, 200, 658, 1000, 550]
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBtnAction()
        customizeChart(dataPoints: players, values: goals.map{ Double($0) })
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
    
    
    //MARK:- UIButton action methods
    private func setupBtnAction() {
        
    }
    
    @IBAction func setSleepGoalAction(_ sender: UIButton) {
        DatePickerDialog().show("Select Time", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: Date(), minimumDate: Date().startOfDay, maximumDate: Date().endOfDay, datePickerMode: .time) { (selectedDate) in
            let selectedTime = DateUtils.getStringFromDate(date: selectedDate ?? Date(), toFormate: DateFormat.onlyHours.rawValue)
            self.sleepGoalBtn.setTitle(selectedTime, for: .normal)
        }
    }

}
                                                                                                                                                                                                
