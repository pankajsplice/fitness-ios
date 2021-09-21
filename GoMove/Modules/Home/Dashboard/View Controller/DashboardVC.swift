//
//  DashboardVC.swift
//  GoMove
//

import UIKit
import CoreBluetooth

final class DashboardVC: BaseViewController,ZHBlePeripheralDelegate,ZHBleSportDataSource {
    func setUserHeight() -> CGFloat {
        return 160.0
    }

    func setUserWeight() -> CGFloat {
        return 45.0;
    }
    

    //MARK:- IBOutlets
    @IBOutlet private weak var stepsCountLbl: UILabel!
    @IBOutlet private weak var heartRateCountLbl: UILabel!
    @IBOutlet private weak var activityCountLbl: UILabel!
    @IBOutlet private weak var bloodaPressureLbl: UILabel!
    @IBOutlet private weak var sleepLbl: UILabel!
    @IBOutlet private weak var stepsBtn: ActionButton!
    @IBOutlet private weak var heartBtn: ActionButton!
    @IBOutlet private weak var activityBtn: ActionButton!
    @IBOutlet private weak var bloodBtn: ActionButton!
    @IBOutlet private weak var sleepBtn: ActionButton!
    
    var blePeripheral = ZHBlePeripheral()
    var foundPeripherals = NSMutableArray()
    var peripheral: CBPeripheral?
    var cbManager = CBCentralManager()
    
    var cmdTool = ZHSendCmdTool()
    var stepsData = [Int]()
    //MARK:- Variable Declarations
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.blePeripheral = ZHBlePeripheral.sharedUartManager()
        self.blePeripheral.delegate = self
        self.blePeripheral.sportDataSource = self
        //cmdTool = ZHSendCmdTool.shareIntance()
       
        customNavView.logoBtn.isHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    func didUpdateBlueToothState(_ central: CBCentralManager?) {
        if central?.state == .poweredOn {
           setUpWatch()
        }
        else
        {
            //show alert view for bluetooth open
        }

    }
    
    func setUpWatch()
    {
        if ZHBlePeripheral.sharedUartManager().mConnected == true {
          print("Connected")
            self.fetchStepsData()
        }
        else{
         connectWatch()
        }
    }
    
    func connectWatch()
    {
        ZHBlePeripheral.sharedUartManager().scanDevice()
    }
    func didConnect(_ peripheral: CBPeripheral!) {
        print("connected")
        self.fetchStepsData()
    }
    
    func didDisconnectPeripheral(_ peripheral: CBPeripheral!) {
        print("disconnect")
    }
    
    func didFail(toConnect peripheral: CBPeripheral!) {
        print("fail")
    }
    
    func connectPeripheralError(_ error: String!) {
        print(error)
    }
    
    func notfindAvailableDevice(_ peripheral: CBPeripheral!) {
        print("notfindAvailableDevice")
    }
    
    func didFind(_ peripheral: CBPeripheral?, advertisementData: [AnyHashable : Any]?, rssi RSSI: NSNumber?, isSupportBind flag: Bool, isBinded status: Bool) {
        print("didFindPeripheral: \(peripheral?.name ?? ""),IsSupportBind: \(flag),IsBinded: \(status)")
        if let peripheral = peripheral {
            if !foundPeripherals.contains(peripheral) && (peripheral.name?.count ?? 0) > 5 {

                let lastStr = (peripheral.name as NSString?)?.substring(from: (peripheral.name?.count ?? 0) - 5)

                let first = (lastStr as NSString?)?.substring(to: 1) //字符串开始


                if first == "_" {
                    foundPeripherals.add(peripheral)
                }
                if(foundPeripherals.count > 0)
                {
                    tryingToConnect()
                }
            }
        }
    }
    
    func tryingToConnect()
    {
        let mainQueue = DispatchQueue.main
        mainQueue.async(execute: { [self] in
            for obj in foundPeripherals
            {
                let peripheral = obj as? CBPeripheral
                if(peripheral?.identifier.uuidString == UserDefaults.standard.value(forKey: UserDefaultConstants.watchIdentifer.value) as? String)
                {
            

                    self.peripheral = peripheral
                }
                else
                {
                continue
                }
            }

        })
        mainQueue.async(execute: { [self] in

            //连接蓝牙
            ZHBlePeripheral.sharedUartManager().didDisconnect()
            ZHBlePeripheral.sharedUartManager().mPeripheral = self.peripheral
            ZHBlePeripheral.sharedUartManager().didConnect()
            
        })
    }
    
    //MARK:- Helper methods
    
    
    //MARK:- UIButton action methods
    @IBAction private func selectModuleAction(_ sender: UIButton) {
        switch sender {
        case stepsBtn:
            let nextVC = StepsDetailVC.instantiateFrom(storyboard: .home)
            nextVC.stepsData = self.stepsData
            self.navigationController?.pushViewController(nextVC, animated: true)
            break
        case heartBtn:
            let nextVC = HeartDetailVC.instantiateFrom(storyboard: .home)
            self.navigationController?.pushViewController(nextVC, animated: true)
            break
        case activityBtn:
            let nextVC = ActivityDetailVC.instantiateFrom(storyboard: .home)
            self.navigationController?.pushViewController(nextVC, animated: true)
            break
        case bloodBtn:
            let nextVC = BloodPressureDetailVC.instantiateFrom(storyboard: .home)
            self.navigationController?.pushViewController(nextVC, animated: true)
            break
        case sleepBtn:
            let nextVC = SleepDetailVC.instantiateFrom(storyboard: .home)
            self.navigationController?.pushViewController(nextVC, animated: true)
            break
        default:
            break
        }
    }

    func fetchStepsData()
    {
        self.cmdTool = ZHSendCmdTool.shareIntance()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        self.cmdTool.synchronizeTime()
        }
    }
    
    func getSportForDate(_ sportDate: String!, andStepData sportData: [Any]!, andDistance distance: CGFloat, andKcal kcal: CGFloat) {
        print(String(format: "----sportDate=%@----sportData=%@----distance=%.2f----sportData=%.0f", sportDate ?? "", sportData ?? [], distance, kcal))
        var sumSteps = 0
        for obj in sportData as! [Int]
        {
            sumSteps = sumSteps + obj
        }
        print(sumSteps)
        stepsData = sportData as! [Int]
        self.stepsCountLbl.text = String(format:"%d",sumSteps);
        apiUpdateStepsData(sportDate: sportDate, sportCalorie: String(format: "%.0f" , kcal), sportData: self.stepsCountLbl.text ?? "", sportDistance: String(format: "%.2f" , distance), sportStep: self.stepsCountLbl.text ?? "")
    }
}

extension DashboardVC
{
    func apiUpdateStepsData(sportDate: String, sportCalorie: String, sportData: String, sportDistance: String, sportStep: String)
    {
        self.requestAPI(endpoint: UserEndpoint.motionInfo(["motion_calorie":sportCalorie,"motion_data":sportData,"motion_date": sportDate,"motion_distance":sportDistance,"motion_step":sportStep])) { response in
            print(response)
        }
    }
}
