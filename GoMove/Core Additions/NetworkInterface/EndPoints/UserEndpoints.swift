
import Alamofire

enum UserEndpoint: Endpoint {
    
    case login(Parameters),
         updateProfile(Int, Parameters)
    
    var url: String {
        switch self {
        case .login: return "user/login"
        case .updateProfile(let userId, _): return "user/profileupdate/\(userId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
//        case :
//            return .get
        
        case .updateProfile:
            return .put
        
        case .login:
            return .post
            
//        case :
//            return .delete
            
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .login(let params),
             .updateProfile(_, let params):
            return params
            
//        default:
//            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .login,
             .updateProfile:

            return URLEncoding.httpBody
        
//        case  :
//            return URLEncoding.queryString
            
//        default:
//            return JSONEncoding.default
        }
    }
}

