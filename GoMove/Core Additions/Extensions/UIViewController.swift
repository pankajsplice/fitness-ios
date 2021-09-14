
import Foundation
import UIKit

extension UIViewController {
    
    // MARK: - load Nib
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }
    
    static func loadFromStoryBoard(name : String = "Onboarding") -> Self {
        func instantiateFromStoryBoard<T: UIViewController>() -> T {
            var fullName: String = NSStringFromClass(T.self)
            let storyboard = UIStoryboard(name: name, bundle: nil)
            if let range = fullName.range(of:".", options:.backwards, range:nil, locale: nil){
                fullName = String(fullName[range.upperBound...])
            }
            return storyboard.instantiateViewController(withIdentifier:fullName) as! T
        }
        return instantiateFromStoryBoard()
    }
    
}
