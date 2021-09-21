//
//  AppDelegate.swift
//  GoFit
//


import UIKit
import IQKeyboardManagerSwift
import CoreBluetooth

@main
class AppDelegate: UIResponder, UIApplicationDelegate,ZHBlePeripheralDelegate {

    var window: UIWindow?
    var appNav: UINavigationController?
    static let shared = UIApplication.shared.delegate as! AppDelegate

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        appConfigurations()
        navigateAsPerLoginStatus()
        
        return true
    }
    
    //MARK:- Configure application
    private func appConfigurations() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
    }

}

