//
//  Utility.swift
//  AlgoworksBase
//


import UIKit
import Photos
import Alamofire
import CoreLocation

final class Utility {
    /**
     Method to execute a task on main queue after a delay, can be used in place of perform selector for better performance.
     - parameter delay: A double value of time you want to perform the task after the current time
     - parameter task: A closure that encloses tha task you want to perform
     
     */
    static func executeTaskOnMain(after delay: Double = 0, task: @escaping ()-> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { task() }
    }
    
    /**
     Method to execute a task on main queue after a delay, can be used in place of perform selector for better performance.
     - parameter delay: A double value of time you want to perform the task after the current time
     - parameter task: A closure that encloses tha task you want to perform
     */
    static func executeTaskOnBackgroundThread(after delay: Double, task: @escaping ()-> Void) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + delay) { task() }
    }
    
    /**
     Method to open the settings application
     */
    static let methodToOpenSettings = {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: {
                (success) in })
        } else {
            guard UIApplication.shared.openURL(url) else {
                AppDelegate.shared.window?.rootViewController?
                    .showAlertViewWith(message: .internetError, buttons: .ok(nil))
                return
            }
        }
    }
    
}
