import Foundation

enum UserDefaultConstants {
    case loginToken, name, email, userId, userData
    
    var value: String {
        switch self {
        case .loginToken: return "usersLoginTokenSavedWhileLogin"
        case .name: return APIKeys.fullName.key
        case .email: return APIKeys.email.key
        case .userId: return "userId"
        case .userData: return "userData"
        }
    }
}

