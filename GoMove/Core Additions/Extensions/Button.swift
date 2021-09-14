

import UIKit

@IBDesignable class ActionButton : UIButton {
    
    var touchUp: ((_ button: UIButton) -> ())?
    
    override func awakeFromNib() {
        setupButton()
    }
    var indexPath:IndexPath?
    func setupButton() {
        //this is my most common setup, but you can customize to your liking
        addTarget(self, action: #selector(touchUp(sender:)), for: [.touchUpInside])
    }
    
    @IBAction func touchUp(sender: UIButton) {
        touchUp?(sender)
    }
    
    override open var isEnabled: Bool {
        didSet {
            DispatchQueue.main.async {
                if self.isEnabled {
                    self.alpha = 1.0
                }
                else {
                    self.alpha = 0.6
                }
            }
        }
    }
    
}

extension UIButton {
//    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        return self.bounds.contains(point) ? self : nil
//    }
    func blink(enabled: Bool = true, duration: CFTimeInterval = 1.0, stopAfter: CFTimeInterval = 0.0 ) {
        enabled ? (UIView.animate(withDuration: duration, //Time duration you want,
            delay: 0.0,
            options: [.curveEaseInOut, .autoreverse, .repeat],
            animations: { [weak self] in self?.alpha = 0.0 },
            completion: { [weak self] _ in self?.alpha = 1.0 })) : self.layer.removeAllAnimations()
        if !stopAfter.isEqual(to: 0.0) && enabled {
            DispatchQueue.main.asyncAfter(deadline: .now() + stopAfter) { [weak self] in
                self?.layer.removeAllAnimations()
            }
        }
    }
    
    func zoomInOut(isAnimate: Bool) {
        let zoomInAndOut = CABasicAnimation(keyPath: "transform.scale")
        zoomInAndOut.fromValue = 1.1
        zoomInAndOut.toValue = 0.8
        zoomInAndOut.duration = 2.0
        zoomInAndOut.repeatCount = 1000
        zoomInAndOut.autoreverses = true
        zoomInAndOut.speed = 2.0
        (isAnimate) ? self.layer.add(zoomInAndOut, forKey: nil) : self.layer.removeAllAnimations()
    }

}



