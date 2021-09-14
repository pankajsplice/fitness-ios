
import Alamofire

extension Endpoint {
    private func logRequest(with response: AFDataResponse<Any>) {
        #if DEBUG
        debugPrint("********************************* API Request **************************************")
        debugPrint("Request URL:\(base+url)")
        debugPrint("Request Parameters: \(parameters ?? [:])")
        debugPrint("Request Headers: \(headers)")
        debugPrint("Request Response ---------->")
        if let data = response.data {
            debugPrint(NSString(data: data, encoding: String.Encoding.utf8.rawValue) ?? "")
        } else {
            debugPrint("Invalid response")
        }
        debugPrint("************************************************************************************")
        #endif
    }
    
    /**
     Method to handle the response from server, it is used by the endpoint execute method, and the upload manager
     - parameter response: The AFDataResponse from the server
     - parameter showIndicator: False if you want to interact without the activity indicator
     - parameter completion: A Closure to handle the response from the server
     */
    func handle(
        response: AFDataResponse<Any>,
        withHiddenIndicator showIndicator: Bool,
        withCompletion completion: WebResponseClosure
    ) {
        logRequest(with: response)
        
        switch response.result {
        case .success(let anyValue):
            guard let dicResponse = anyValue as? NSDictionary, let code = response.response?.statusCode else {//dicResponse["status"] as? Int else {
                return
            }
			 Indicator.shared.hide()
            if code == 200 {
                Utility.executeTaskOnMain {
                    completion?(.success(anyValue as AnyObject))
                }
            }else{
                guard let dicError = dicResponse["error"] as? NSDictionary else {return}
                let message = dicError["message"] as? String ?? ""
                
                Utility.executeTaskOnMain{
                    if code == 401 {
                        UIApplication.shared.keyWindow?.topViewController()?.showAlertViewWith(message: .custom("You are also login with onther device. Kindly login again."), buttons: .ok({
                            UserDefaultsManager.removeSavedUserDefaults()
                            AppDelegate.shared.navigateAsPerLoginStatus()
                        }))
                    }
                    else if code == 403 {
                        UIApplication.shared.keyWindow?.topViewController()?.showAlertViewWith(message: .custom(message), buttons: .ok({
                            UserDefaultsManager.removeSavedUserDefaults()
                            AppDelegate.shared.navigateAsPerLoginStatus()
                        }))
                    }
                    else{
                        UIApplication.shared.keyWindow?.topViewController()?.showAlertViewWith(message: .custom(message), buttons: .ok(nil))
                    }
                }
            }
        case .failure(let error):
            #if DEBUG
            print(error)
            #endif
            lookoutForHTTPErrors(in: response.response)
        }
    }
}
