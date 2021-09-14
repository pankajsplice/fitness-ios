
import Foundation

struct Validator {
    
    static let numberSet = "0123456789"
    static let characterSet = "abcdefghijklmnopqrstuvwxyz "
    static let alphaNumericSet = "\(numberSet)\(characterSet)\(characterSet.uppercased())"

    /**
     Method to check if the email is valid or not.
     - parameter email: email string entered by the user
     - returns Bool: returns a bool as per the validity of the passed email
     */
    func isValid(email: String) -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    /**
     Method to check if the password is valid or not.
     - parameter number: Number string entered by the user
     - returns Bool: returns a bool as per the validity of the passed number
     */
    
    func isValidPhone(number: String) -> Bool {
        let phoneRegex: String = "[0-9]{10,15}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: number)
    }
    
    /**
     Method to check if the password is valid or not. (One uppercase, one lowercase and one special character, min length 8)
     - parameter mypassword: password string entered by the user
     - returns Bool: returns a bool as per the validity of the passed password
     */
    
    func isValidpassword(mypassword : String) -> Bool
        {
            let passwordreg =  ("(?=.*[A-Z])(?=.*[a-z])(?=.*[@#$%^&*]).{8,}")
            let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
            return passwordtesting.evaluate(with: mypassword)
        }

    /**
     Method to check if the password is valid or not.
     - parameter text: string entered by the user
     - returns Bool: returns a bool as per the validity of the passed string
     */
    func isAlphabet(_ text: String) -> Bool {
        let phoneRegex: String = ".*[^A-Za-z].*"
        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: text)
    }
}
