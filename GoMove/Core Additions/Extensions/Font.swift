

import UIKit

extension UIFont {
    enum MontserratFont {
        case MontserratRegular, MontserratItalic, MontserratBold,MontserratBoldItalic, MontserratSemiBold, MontserratMedium, MontserratLight, MontserrateExtraBold
        
        var value: String {
            switch self {
            case .MontserratRegular: return "Montserrat-Regular"
            case .MontserratItalic: return "Montserrat-Italic"
            case .MontserratBold: return "Montserrat-Bold"
            case .MontserratBoldItalic: return "Montserrat-BoldItalic"
            case .MontserratSemiBold: return "Montserrat-SemiBold"
            case .MontserratMedium: return "Montserrat-Medium"
            case .MontserratLight: return "Montserrat-Light"
            case .MontserrateExtraBold: return "Montserrat-ExtraBold"
            }
        }
    }
    
    /**
     Custom font described by the properties as per the parameters
     - parameter font: Font instance for desired font properties
     - parameter size: CGFloat for desired font size
     - returns: UIFont instance with the desired properties
     */
    static func custom(font: MontserratFont, ofSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: font.value, size: size) else {
            return systemFont(ofSize: size)
        }
        return font
    }
}
