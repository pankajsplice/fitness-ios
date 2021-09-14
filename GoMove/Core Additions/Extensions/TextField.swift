
import UIKit

extension UITextField {
    var isBlank: Bool {
        return (text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var trimmedText: String {
        return (text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension UITextField {
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
extension UITextField {
    enum Side {
        case left, right
    }
    
    /**
     Show padding in a textfield
     - parameter value: Size of padding intended
     - parameter side: Side of padding intended
     */
    func setPadding(of value: CGFloat, towards side: Side) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: frame.size.height))
        switch side {
        case .left:
            leftView = paddingView
            leftViewMode = .always
        case .right:
            rightView = paddingView
            rightViewMode = .always
        }
    }
}
private var maxLengthAssociated = Int()
extension UITextField {
    @IBInspectable var limit: Int {
        get {
            if let length = objc_getAssociatedObject(self, &maxLengthAssociated) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &maxLengthAssociated, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength(_:)), for: .editingChanged)
        }
    }
    
    @objc private func checkMaxLength(_ textField: UITextField) {
        guard let prospectiveText = textField.text,
            prospectiveText.count > limit else { return }
        let selection = selectedTextRange
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: limit)
        text = String(prospectiveText[..<indexEndOfText])
        selectedTextRange = selection
    }
}

