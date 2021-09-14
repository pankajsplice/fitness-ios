
import Alamofire

struct MediaUploadManager {
    /**
     Method to upload media files to server
     - parameter media: A variadic parameter, that takes Media objects that need to be uploaded
     - parameter endpoint: An endpoint throught which the files should be uploaded
     - parameter showIndicator: False if you want to interact without the activity indicator
     - parameter completion: A Closure to handle the response from the server
     */
    func upload(
        media: Media...,
        at endpoint: Endpoint,
        withHiddenIndicator showIndicator: Bool = true,
        withCompletion completion: WebResponseClosure = nil
    ) {
        guard let networkReachable = NetworkReachabilityManager.default?.isReachable,
            networkReachable else {
                displayAlertWithSettings()
                return
        }
        
        if showIndicator {
            Indicator.shared.show()
        }
        
        let formdata = preparedMultipart(from: media, for: endpoint)
        
        AF.upload(
            multipartFormData: formdata,
            to: endpoint.base+endpoint.url,
            usingThreshold: .min,
            method: endpoint.method,
            headers: endpoint.headers
        ).responseJSON(queue: uploadQueue) { response in
            endpoint.handle(
                response: response,
                withHiddenIndicator: showIndicator,
                withCompletion: completion
            )
        }
    }
    func uploadmulti(
        media: [Media],
        at endpoint: Endpoint,
        withHiddenIndicator showIndicator: Bool = true,
        withCompletion completion: WebResponseClosure = nil
    ) {
        guard let networkReachable = NetworkReachabilityManager.default?.isReachable,
            networkReachable else {
                displayAlertWithSettings()
                return
        }
        
        if showIndicator {
            Indicator.shared.show()
        }
        
        let formdata = preparedMultipart(from: media, for: endpoint)
        
        AF.upload(
            multipartFormData: formdata,
            to: endpoint.base+endpoint.url,
            usingThreshold: .min,
            method: endpoint.method,
            headers: endpoint.headers
        ).responseJSON(queue: uploadQueue) { response in
            endpoint.handle(
                response: response,
                withHiddenIndicator: showIndicator,
                withCompletion: completion
            )
        }
    }
    private var uploadQueue: DispatchQueue {
        return DispatchQueue(
            label: "com.algo.Addison-Clifton.upload",
            qos: .background,
            attributes: .concurrent,
            autoreleaseFrequency: .inherit,
            target: .global(qos: .default)
        )
    }
    
    private func preparedMultipart(
        from media: [Media],
        for endpoint: Endpoint
    ) -> ((MultipartFormData) -> Void) {
        return { formdata in
            if let params = endpoint.parameters {
                params.forEach {
                    formdata.append(
                        ($1 as AnyObject).data(using: String.Encoding.utf8.rawValue)!,
                        withName: $0
                    )
                }
            }
            
            media.forEach {
                formdata.append(
                    $0.data!, withName: $0.key!, fileName: $0.format?.fileName, mimeType: $0.format?.mime
                )
            }
        }
    }
    
    private func displayAlertWithSettings() {
        Utility.executeTaskOnMain {
            UIApplication.shared.keyWindow?.topViewController()?.showAlertViewWith(message: .internetError, buttons: .ok(nil), .settings)
        }
    }
}

