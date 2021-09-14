
import Foundation

final class UserDefaultsManager {
    static func set(value: Any, forKey key: UserDefaultConstants) {
        UserDefaults.standard.setValue(value, forKey: key.value)
        UserDefaults.standard.synchronize()
    }

    static var loginToken: String? {
        set {
            set(value: newValue ?? "", forKey: .loginToken)
        } get {
            guard let token = UserDefaults.standard
                .string(forKey: UserDefaultConstants.loginToken.value) else {
                return nil
            }
            return token == "" ? nil : token
        }
    }
    
    static var userData: UserDetails? {
        set {
            set(value: try? PropertyListEncoder().encode(newValue), forKey: .userData)
        } get {
            guard let data = UserDefaults.standard.value(forKey: UserDefaultConstants.userData.value) as? Data else {
                return nil
            }
            let userData = try? PropertyListDecoder().decode(UserDetails.self, from: data)
            return userData
        }
    }
    
    static func removeSavedUserDefaults() {
        UserDefaultsManager.loginToken = nil
        
        UserDefaults.standard.removeObject(forKey: "recentSearch")
        
    }
    
}
