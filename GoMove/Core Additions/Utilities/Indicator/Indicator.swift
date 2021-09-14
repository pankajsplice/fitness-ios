//
//  Default Apple provided activity Indicator, can be modified as per requirements
//
import UIKit

final class Indicator {
    static let shared = Indicator()
    
    private var indicator = UIActivityIndicatorView()
    private var viewMain = UIView()
    
    private init() {
        viewMain.frame = AppDelegate.shared.window?.frame ?? .zero
        viewMain.backgroundColor = .clear
        if #available(iOS 13.0, *) {
            indicator.style = .large
        }else{
            indicator.style = .whiteLarge
        }
        indicator.startAnimating()
        indicator.center = AppDelegate.shared.window?.center ?? CGPoint.zero
        indicator.color = Constants.Colors.theme.value
        viewMain.addSubview(indicator)
    }
    
    func show(withBackground value: Bool = false, color: UIColor = Constants.Colors.theme.value) {
        DispatchQueue.main.async() { [unowned self] in
            AppDelegate.shared.window?.addSubview(self.viewMain)
		//	UIApplication.shared.keyWindow?.addSubview(self.viewMain)
        }
    }
    
    func hide(){
        DispatchQueue.main.async() { [weak self] in
            self?.viewMain.removeFromSuperview()
        }
    }
}

