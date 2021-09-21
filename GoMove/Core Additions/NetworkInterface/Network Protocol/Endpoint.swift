
import Alamofire

typealias WebResponseClosure = ((Result<AnyObject, EndpointError>) -> Void)?

protocol Endpoint {
    var url: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders { get }
    var encoding: ParameterEncoding { get }
}

//MARK: - Common Properties and Configurations
// these are the basics, we can add more of such details as per the project requirements
extension Endpoint {
    var base: String {
        guard let baseURL = Bundle.main.infoDictionary?["BaseURL"] as? String else {
            return "https://gofit.keycorp.in/"
        }
        return baseURL
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        switch self {
        default:
            if let token = UserDefaultsManager.loginToken,
                token != Constants.Defaults.token {
                headers["Authorization"] = "Token \(token)"
            }
        }
        return headers
    }
    
    var request: DataRequest {
        return AF.request(base + url, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
}
