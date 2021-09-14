
import Alamofire

extension Endpoint {
    /**
     for background thread
     */
    private var requestQueue: DispatchQueue {
        return DispatchQueue(
            label: "com.gofit",
            qos: .background,
            attributes: .concurrent,
            autoreleaseFrequency: .inherit,
            target: .global(qos: .default)
        )
    }
    
    /**
     Method for interacting with the server for data
     - parameter api: Endpoints object for preferred data from the server
     - parameter showIndicator: False if you want to interact without the activity indicator
     - parameter completion: A Closure to handle the response from the server
     */
    func request(
        withHiddenIndicator showIndicator: Bool = true,
        withCompletion completion: WebResponseClosure = nil
    ) {
		Indicator.shared.show()
        guard let networkReachable = NetworkReachabilityManager.default?.isReachable,
            networkReachable else {
                displayAlertWithSettings()
                return
        }
        
        if showIndicator {
            Indicator.shared.show()
        }
        
        request.responseJSON(queue: requestQueue) { response in
			Indicator.shared.hide()
            self.handle(
                response: response,
                withHiddenIndicator: showIndicator,
                withCompletion: completion
            )
        }
    }
    
    private func displayAlertWithSettings() {
        Utility.executeTaskOnMain {
            UIApplication.shared.keyWindow?.topViewController()?.showAlertViewWith(message: .internetError, buttons: .ok(nil))
        }
    }
}
