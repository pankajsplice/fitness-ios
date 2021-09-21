import Foundation

enum AlertMessages {
    case custom(String?),
         internetError,
         givePermissionToCameraAccess,
         cameraSupport,
         usernameAlert,
         passwordAlert,
         conPassAlert,
         passwordMatchAlert,
         nickNameAlert,
         heightAlert,
         weightAlert,
         dobAlert,
         genderAlert,
         emailAlert,
         otpAlert,
         profilePicAlert,
         invalidEmailAlert,
         logoutAlert,
         cameraNeeded,
         stepGoal
    
    
    var value: String? {
        switch self {
        case .custom(let message): return message
        case .internetError: return "INTERNETERROR".localized
        case .givePermissionToCameraAccess: return "GIVEPERMISSIONFORCAMERAACCESS".localized
        case .cameraSupport: return "CAMERASUPPORT".localized
        case .usernameAlert: return "USERNAMEALERT".localized
        case .emailAlert: return "EMAILALERT".localized
        case .otpAlert: return "OTPALERT".localized
        case .profilePicAlert : return "PROFILEPICALERT".localized
        case .invalidEmailAlert: return "INVALIDEMAIL".localized
        case .logoutAlert: return "LOGOUTALERT".localized
        case .cameraNeeded: return "CAMERANEEDED".localized
        case .passwordAlert: return "PASSWORDALERT".localized
        case .conPassAlert: return "CONPASSALERT".localized
        case .passwordMatchAlert: return "PASSMATCHALERT".localized
        case .nickNameAlert: return "NICKNAMEALERT".localized
        case .heightAlert: return "HEIGHTALERT".localized
        case .weightAlert: return "WEIGHTALERT".localized
        case .dobAlert: return "DOBALERT".localized
        case .genderAlert: return "GENDERALERT".localized
        case .stepGoal: return "STEPGOAL".localized
        }
    }
    
}
