
import UIKit

extension Constants {
    enum Colors: String {
        case theme
        
        var value: UIColor {
            return UIColor(named: rawValue) ?? .black
        }
    }
}
