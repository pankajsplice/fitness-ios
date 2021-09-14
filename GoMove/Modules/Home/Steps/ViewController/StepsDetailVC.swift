//
//  StepsDetailVC.swift
//  GoMove
//


import UIKit
import KDCircularProgress
import Charts

final class StepsDetailVC: BaseViewController,ZHBleSportDataSource,ZHBleMultiSportDelegate,ZHBlePeripheralDelegate,ZHBleHealthDataSource,ZHOtherDataSource,ZHThemeDelegate,ZHBleGPSSportDelegate,ZHBleFileTransferDelegate,ZHBleDeviceBindDelegate {
    func setCalibrationHR() -> Int32 {
        return 70;
    }
    
    func setCalibrationSystolic() -> Int32 {
        return 120;
    }
    
    func setCalibrationDiastolic() -> Int32 {
        return 70;
    }
    
    func setUserHeight() -> CGFloat {
        return 160.0
    }
    
    func setUserWeight() -> CGFloat {
        return 45.0;
    }
    

    //MARK:- IBOutlets
    @IBOutlet private weak var circularProgress: KDCircularProgress!
    @IBOutlet private weak var todayBtnAction: ActionButton!
    @IBOutlet private weak var previousWeekAction: ActionButton!
    @IBOutlet private weak var nextWeekAction: ActionButton!
    @IBOutlet private weak var stepGoalBtnAction: ActionButton!
    @IBOutlet private weak var cancelBtnAction: ActionButton!
    @IBOutlet private weak var okBtnAction: ActionButton!
    @IBOutlet private weak var todayStepCountLbl: UILabel!
    @IBOutlet private weak var weekDatesLbl: UILabel!
    @IBOutlet private weak var minStepCountLbl: UILabel!
    @IBOutlet private weak var maxStepCountLbl: UILabel!
    @IBOutlet private weak var avgStepCountLbl: UILabel!
    @IBOutlet private weak var stepCountTxtField: UITextField!
    @IBOutlet private weak var stepCountPopupView: UIView!
    
    @IBOutlet weak var barChartView: BarChartView!
    
    //MARK:- Variable Declarations
    var todayStepsCount: Int    = 1800
    var totalStepGoalCount: Int = 3000
    
    let players = ["S", "M", "T", "W", "T", "F", "S"]
    let goals = [6, 8, 26, 30, 8, 10, 15]
    
    //Dates
    var weekEndDate = Date()
    var weekStartDate = Date()
    
    var cmdTool: ZHSendCmdTool?
    var blePeripheral: ZHBlePeripheral?

    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blePeripheral = ZHBlePeripheral.sharedUartManager()
        cmdTool = ZHSendCmdTool.shareIntance()
       
        
        setupBtnAction()
        let completeDate = setDatesForSevenDays(weekLastDate: Date().startOfDay)
        weekDatesLbl.text = "\(completeDate.0) - \(completeDate.1)"
        calculateCircularProgress()
        customizeChart(dataPoints: players, values: goals.map{ Double($0) })
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //blePeripheral?.delegate = self;
        blePeripheral?.sportDataSource = self;
//        blePeripheral?.healthDataSource = self;
//        blePeripheral?.otherDataSource = self;
//        blePeripheral?.multiSportDelegate = self;
//        blePeripheral?.fileTransferDelegate = self;
//        blePeripheral?.gpsSportDelegate = self;
//        blePeripheral?.deviceBindDelegate = self;
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
            if ZHBlePeripheral.sharedUartManager().mConnected == true {
                self.cmdTool?.synchronizeTime()
            }
        }
    }
    
    //MARK:- Helper methods
    
    func getSportForDate(_ sportDate: String!, andStepData sportData: [Any]!, andDistance distance: CGFloat, andKcal kcal: CGFloat) {
        print(String(format: "----sportDate=%@----sportData=%@----distance=%.2f----sportData=%.0f", sportDate ?? "", sportData ?? [], distance, kcal))
    }
    
//     func getSportForDate(_ sportDate: String?, andStepData sportData: [AnyHashable]?, andDistance distance: CGFloat, andKcal kcal: CGFloat) {
//        print(String(format: "----sportDate=%@----sportData=%@----distance=%.2f----sportData=%.0f", sportDate ?? "", sportData ?? [], distance, kcal))
////        if let value = sportData?.value(forKeyPath: "@sum.intValue") {
////         //   lbSteps.text = "\(value)"
////            print("\(value)")
////        }
//        print(String(format: "%.2f km", distance))
//        print(String(format: "%.0f kcal", kcal))
//    }
//
    
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
    
    private func stepCountPopupViewIn(){
        stepCountPopupView.layer.shadowColor = UIColor.darkGray.cgColor
        stepCountPopupView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
        stepCountPopupView.layer.shadowOpacity = 0.1
        stepCountPopupView.layer.shadowOffset = CGSize.zero
        stepCountPopupView.layer.shadowRadius = 10
        self.view.addSubview(stepCountPopupView)
        stepCountPopupView.center = self.view.center
        stepCountPopupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        stepCountPopupView.alpha = 0
        UIView.animate(withDuration: 0.4){
            self.stepCountPopupView.alpha = 1
            self.stepCountPopupView.transform = CGAffineTransform.identity
        }
        stepCountPopupView.frame = self.view.frame
    }
    
    private func stepCountPopupViewOut(){
        UIView.animate(withDuration: 0.3, animations:{
            self.stepCountPopupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.stepCountPopupView.alpha = 0
        }){ (success: Bool) in
            self.stepCountPopupView.removeFromSuperview()
        }
    }
    
    //Setup Date range
    private func setDatesForSevenDays(weekLastDate: Date) -> (String,String) {
        weekEndDate = weekLastDate
        weekStartDate = weekEndDate.add(component: .day, value: -6)
        let weekEndDateValue = DateUtils.getStringFromDateNew(date: weekEndDate)
        let weekStartDateValue = DateUtils.getStringFromDateNew(date: weekStartDate)
        return (weekStartDateValue,weekEndDateValue)
    }
    
    //Setup progress grediant
    private func calculateCircularProgress() {
        let circularProgressAngle = ((todayStepsCount * 360) / totalStepGoalCount) //360 is the total angle of circular progress
        circularProgress.angle = (circularProgressAngle > 360) ? 360 : Double(circularProgressAngle)
        todayStepCountLbl.text = "\(todayStepsCount)"
        stepGoalBtnAction.setTitle("\(totalStepGoalCount)", for: .normal)
    }
    
    
    //MARK:- UIButton action methods
    private func setupBtnAction() {
        todayBtnAction.touchUp = { button in
            let minimumDate = Calendar.current.date(byAdding: .year, value: -10, to: Date())
            DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: Date(), minimumDate: minimumDate, maximumDate: Date(), datePickerMode: .date) { (selectedDate) in
                let selectedDate = DateUtils.getStringFromDate(date: selectedDate ?? Date(), toFormate: DateFormat.dateMonthYear.rawValue)
                let todayDate = DateUtils.getStringFromDate(date: Date(), toFormate: DateFormat.dateMonthYear.rawValue)
                self.todayBtnAction.setTitle((selectedDate == todayDate) ? "Today" : selectedDate, for: .normal)
            }
               
        }
        
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
        
        cancelBtnAction.touchUp = { button in
            self.stepCountPopupViewOut()
        }
        
        okBtnAction.touchUp = { button in
            if self.stepCountTxtField.text == "" {
                self.uidelegate?.show(message: .stepGoal)
            } else {
                self.totalStepGoalCount = (self.stepCountTxtField.text)?.toInt() ?? 0
                self.calculateCircularProgress()
                self.stepCountPopupViewOut()
            }
        }
    }
    
    @IBAction func goalSetBtn(_ sender: UIButton) {
        self.stepCountPopupViewIn()
    }

}

public class ChartFormatter: NSObject, AxisValueFormatter {
    var workoutDuration = [String]()
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return workoutDuration[Int(value)]
    }
    
    public func setValues(values: [String]) {
        self.workoutDuration = values
    }
    
}
