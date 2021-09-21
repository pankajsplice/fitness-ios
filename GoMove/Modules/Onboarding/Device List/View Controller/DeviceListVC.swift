//
//  DeviceListVC.swift
//  GoMove
//


import UIKit
import CoreBluetooth

final class DeviceListVC: UIViewController,ZHBlePeripheralDelegate {

    //MARK:- IBOutlets
    @IBOutlet private weak var devicesTblView: UITableView!
    @IBOutlet private weak var refreshBtn: ActionButton!
    
    var foundPeripherals = NSMutableArray()
    var peripheral: CBPeripheral?
    
    //MARK:- Variable Declarations
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ZHBlePeripheral.sharedUartManager().delegate = self
        foundPeripherals = []
        devicesTblView.tableFooterView = UIView();
        setupBtnAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      //  ZHBlePeripheral.sharedUartManager().scanDevice()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ZHBlePeripheral.sharedUartManager().stopScan()
    }
    
    
    //MARK:- Helper methods
    
    
    //MARK:- UIButton action methods
    func setupBtnAction() {
        refreshBtn.touchUp = { button in
            self.foundPeripherals.removeAllObjects()
            self.devicesTblView.reloadData()
            ZHBlePeripheral.sharedUartManager().scanDevice()
        }
    }
    
    func didUpdateBlueToothState(_ central: CBCentralManager?) {
        if central?.state == .poweredOn {
            ZHBlePeripheral.sharedUartManager().scanDevice()
        }

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


                devicesTblView.reloadData()
            }
        }
    }

    func didConnect(_ peripheral: CBPeripheral!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        UserDefaults.standard.setValue(peripheral.identifier.uuidString, forKey: UserDefaultConstants.watchIdentifer.value)
        
        let nextVC = DashboardVC.instantiateFrom(storyboard: .home)
        self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    func didFail(toConnect peripheral: CBPeripheral!) {
        print("Fail")
    }

}


//MARK:- UITableViewDelegate, UITableViewDataSource methods
extension DeviceListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        foundPeripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DeviceListCell.dequeReusably(for: tableView, at: indexPath)
        let dict = foundPeripherals[indexPath.row] as? CBPeripheral
        print(dict)
        cell.deviceNameLbl.text = dict?.name
        cell.deviceIdLbl.text = dict?.identifier.uuidString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  Converted to Swift 5.4 by Swiftify v5.4.25812 - https://swiftify.com/
        let mainQueue = DispatchQueue.main
        mainQueue.async(execute: { [self] in
            let peripheral = foundPeripherals[indexPath.row] as? CBPeripheral

            self.peripheral = peripheral


        })
        mainQueue.async(execute: { [self] in

            //连接蓝牙
            ZHBlePeripheral.sharedUartManager().didDisconnect()
            ZHBlePeripheral.sharedUartManager().mPeripheral = self.peripheral
            ZHBlePeripheral.sharedUartManager().didConnect()
            
        })
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    
}
