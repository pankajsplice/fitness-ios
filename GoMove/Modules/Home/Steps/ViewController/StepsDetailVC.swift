//
//  StepsDetailVC.swift
//  GoMove
//


import UIKit
import KDCircularProgress
import Charts

final class StepsDetailVC: BaseViewController {

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
   // var todayStepsCount: Int    = 1800
    var totalStepGoalCount: String = "15000"
    
    var stepsData = [Int]()
    
    let players = ["S", "M", "T", "W", "T", "F", "S"]
    var goals = [6, 8, 26, 30, 8, 10, 15]
    
    //Dates
    var weekEndDate = Date()
    var weekStartDate = Date()


    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        stepsCalculation()
        if(UserDefaults.standard.value(forKey: UserDefaultConstants.stepGoal.value) as? String == nil || UserDefaults.standard.value(forKey: UserDefaultConstants.stepGoal.value) as? String == "")
        {
            UserDefaults.standard.setValue("15000", forKey: UserDefaultConstants.stepGoal.value)
        }
        else
        {
            totalStepGoalCount =  UserDefaults.standard.value(forKey: UserDefaultConstants.stepGoal.value) as? String ?? ""
        }
        
        
        setupBtnAction()
        let completeDate = setDatesForSevenDays(weekLastDate: Date().startOfDay)
        weekDatesLbl.text = "\(completeDate.0) - \(completeDate.1)"
       
       

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
       
    }
    
    func stepsCalculation()
    {
        if(stepsData.count > 0)
        {
        var sumSteps = 0
        for obj in stepsData as! [Int]
        {
            sumSteps = sumSteps + obj
        }
        print(sumSteps)
        self.todayStepCountLbl.text = String(format:"%d",sumSteps)
        }
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
        barChartView.leftAxis.axisMinimum = 0
        barChartView.rightAxis.axisMinimum = 0
        
        barChartView.leftAxis.axisMaximum = totalStepGoalCount.toDouble() ?? 0.0
        //barChartView.rightAxis.axisMaximum = 10000
        
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
        apiGetStepsWeeklyData(startDate:DateUtils.getStringFromDate(date: weekStartDate, toFormate: DateFormat.yearMonthDate.rawValue) , endDate: DateUtils.getStringFromDate(date: weekEndDate, toFormate: DateFormat.yearMonthDate.rawValue))
        
        return (weekStartDateValue,weekEndDateValue)
        
    }
    
    //Setup progress grediant
    private func calculateCircularProgress() {
        let circularProgressAngle = (88 * 360) / 100 //360 is the total angle of circular progress
        circularProgress.angle = (circularProgressAngle > 360) ? 360 : Double(circularProgressAngle)
       // todayStepCountLbl.text = "\(todayStepsCount)"
        stepGoalBtnAction.setTitle("\(totalStepGoalCount)", for: .normal)
    }
    
    
    //MARK:- UIButton action methods
    private func setupBtnAction() {
        todayBtnAction.touchUp = { button in
            let minimumDate = Calendar.current.date(byAdding: .year, value: -10, to: Date())
            DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: Date(), minimumDate: minimumDate, maximumDate: Date(), datePickerMode: .date) { (selectedDate) in
                let selectedDated = DateUtils.getStringFromDate(date: selectedDate ?? Date(), toFormate: DateFormat.dateMonthYear.rawValue)
                let todayDate = DateUtils.getStringFromDate(date: Date(), toFormate: DateFormat.dateMonthYear.rawValue)
                self.todayBtnAction.setTitle((selectedDated == todayDate) ? "Today" : selectedDated, for: .normal)
                self.apiGetStepsData(dateString: DateUtils.getStringFromDate(date: selectedDate ?? Date(), toFormate: DateFormat.yearMonthDate.rawValue))
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
                self.totalStepGoalCount = self.stepCountTxtField.text ?? ""
                self.stepGoalBtnAction.setTitle("\(self.totalStepGoalCount)", for: .normal)
                self.stepCountPopupViewOut()
                self.apiSetStepGoal(stepGoal: self.totalStepGoalCount)
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


extension StepsDetailVC
{
    func apiGetStepsData(dateString : String)
    {
        self.requestAPI(endpoint: UserEndpoint.getMotionInfo(dateString , [:])) { response in
            print(response)
            if(response["error"] as? Bool == false)
            {
            if(response["status_code"] as? Int == 200)
            {
            let dict = response["data"] as? [String:Any]
                print(String(format:"%d ",dict?["total_steps"] as? NSInteger ?? ""))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.todayStepCountLbl.text = String(format:"%d ",dict?["total_steps"] as? NSInteger ?? "")
            self.calculateCircularProgress()
            }
            }
            else{
                self.uidelegate?.show(message: .custom(response["message"] as? String))
            }
            }
            else{
                self.uidelegate?.show(message: .custom(response["message"] as? String))
            }
        }
    }
    
    func apiGetStepsWeeklyData(startDate: String , endDate : String)
    {
        self.requestAPI(endpoint: UserEndpoint.getWeeklyMotionInfo(startDate, endDate,  [:])) { response in
            print(response)
            if(response["error"] as? Bool == false)
            {
            if(response["status_code"] as? Int == 200)
            {
            let data = response["data"] as? [String:Any]

            print(String(format: "%.2f", data?["avg_step"] as! Double))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.minStepCountLbl.text = String(format:"%d",data?["min_step"] as? NSInteger ?? "")
            self.maxStepCountLbl.text = String(format:"%d",data?["max_step"] as? NSInteger ?? "")
            self.avgStepCountLbl.text = String(format: "%.f", data?["avg_step"] as! Double)
    
                let days = data?["weekly"] as? [String: Any]
                
                for obj in days!
                {
                    print(obj)
                    switch obj.key {
                    case "Sunday":
                        self.goals[0] = obj.value as! Int
                        break
                    case "Monday":
                        self.goals[1] = obj.value as! Int
                        break
                    case "Tuesday":
                        self.goals[2] = obj.value as! Int
                        break
                    case "Wednesday":
                        self.goals[3] = obj.value as! Int
                        break
                    case "Thursday":
                        self.goals[4] = obj.value as! Int
                        break
                    case "Friday":
                        self.goals[5] = obj.value as! Int
                        break
                    case "Saturday":
                        self.goals[6] = obj.value as! Int
                        break
                
                    default:
                        break
                    }
                }
                
               self.customizeChart(dataPoints: self.players, values: self.goals.map{ Double($0) })
               self.calculateCircularProgress()
            }
            }
            else{
                self.uidelegate?.show(message: .custom(response["message"] as? String))
            }
            }
            else{
                self.uidelegate?.show(message: .custom(response["message"] as? String))
            }
        }
    }
    
    func apiSetStepGoal(stepGoal: String)
    {
        self.requestAPI(endpoint: UserEndpoint.setStepGoal(["step_goal": self.stepCountTxtField.text ?? ""])) { response in
            print(response)
            if(response["error"] as? Bool == false)
            {
            if(response["status_code"] as? Int == 200)
            {
                UserDefaults.standard.setValue(stepGoal, forKey: UserDefaultConstants.stepGoal.value)
             // Update Charts
               self.customizeChart(dataPoints: self.players, values: self.goals.map{ Double($0) })
               self.calculateCircularProgress()
            }
            
            else{
                self.uidelegate?.show(message: .custom(response["message"] as? String))
            }
            }
            else{
                self.uidelegate?.show(message: .custom(response["message"] as? String))
            }
        }
    }
    
    
}
