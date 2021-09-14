import UIKit

typealias NullableCompletion = (()->Void)?

enum AlertTitle {
    case appName
    case custom(String)
    
    var value: String {
        switch self {
        case .appName:
            guard let name = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String else {
                return "GoFit"
            }
            return name
        case .custom(let name): return name
        }
    }
}

enum AlertButton {
    case ok(NullableCompletion), cancel, custom(String, NullableCompletion), settings
    
    var name: String {
        switch self {
        case .ok: return "Ok"
        case .cancel: return "Cancel"
        case .custom(let value, _): return value
        case .settings: return "Settings"
        }
    }
    
    var action: NullableCompletion {
        switch self {
        case .ok(let closure): return closure
        case .cancel: return nil
        case .custom(_, let closure): return closure
        case .settings: return Utility.methodToOpenSettings
        }
    }
    
    var style: UIAlertAction.Style {
        switch self {
        case .cancel: return .cancel
        default: return .default
        }
    }
}
