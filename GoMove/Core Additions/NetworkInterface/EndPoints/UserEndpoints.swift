
import Alamofire

enum UserEndpoint: Endpoint {
    
    case login(Parameters),
         updateProfile(Int, Parameters),
        registration(Parameters),
        forgotPassword(Parameters),
        otpVerify(Parameters),
        resetPassword(Parameters),
        motionInfo(Parameters),
        getMotionInfo(String, Parameters),
        getWeeklyMotionInfo(String, String, Parameters),
        setStepGoal(Parameters)
    
    var url: String {
        switch self {
        case .login: return "api/login/"
        case .updateProfile(let userId, _): return "user/profileupdate/\(userId)"
        case .registration: return "api/register/"
        case .forgotPassword : return "api/send-otp/"
        case .otpVerify : return "api/verify-otp/"
        case .resetPassword : return "api/password-reset/"
        case .motionInfo : return "api/gofit/motion-info/"
        case .getMotionInfo(let dateString, _) : return "api/gofit/steps-by-date?date=\(dateString)"
        case .getWeeklyMotionInfo(let startDate, let endDate, _) : return "api/gofit/steps-by-date-range?from_date=\(startDate)&to_date=\(endDate)"
        case .setStepGoal : return "api/gofit/set-step-goal"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMotionInfo,.getWeeklyMotionInfo:
            return .get
        
        case .updateProfile:
            return .put
        
        case .login,.registration,.forgotPassword,.otpVerify,.resetPassword,.motionInfo,.setStepGoal:
            return .post
            
            
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .login(let params),
             .updateProfile(_, let params),
            .registration(let params),
            .forgotPassword(let params),
            .otpVerify(let params),
            .resetPassword(let params),
            .motionInfo(let params),
            .getMotionInfo(_, let params),
            .getWeeklyMotionInfo(_,_,let params),
            .setStepGoal(let params):
            return params
            
//        default:
//
        
        
    }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .login,
             .updateProfile,
            .registration,
            .forgotPassword,
            .otpVerify,
            .resetPassword,
            .motionInfo,
            .setStepGoal:

            
            return URLEncoding.httpBody
        
        case .getMotionInfo,.getWeeklyMotionInfo :
            return URLEncoding.queryString
            
//        default:
//            return JSONEncoding.default
        }
    }
}

