//
//  RegistrationVC.swift
//  GoMove
//

import UIKit

final class RegistrationVC: BaseViewController {

    //MARK:- IBOutlets
    @IBOutlet private weak var emailTxtField: UITextField!
    @IBOutlet private weak var nickNameTxtField: UITextField!
    @IBOutlet private weak var passwordTxtField: UITextField!
    @IBOutlet private weak var conPasswordTxtField: UITextField!
    @IBOutlet private weak var heightTxtField: UITextField!
    @IBOutlet private weak var weightTxtField: UITextField!
    @IBOutlet private weak var dobTxtField: UITextField!
    @IBOutlet private weak var genderTxtField: UITextField!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var imageBtn: ActionButton!
    @IBOutlet private weak var dobBtn: ActionButton!
    @IBOutlet private weak var signupBtn: ActionButton!
    
    //MARK:- Variable Declarations
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBtnAction()
        customNavView.settingBtn.isHidden = true
    }
    
    //MARK:- Helper methods
    private func validateFields() -> Bool {
        var isVerified = false
        if emailTxtField.text == "" {
            uidelegate?.show(message: .emailAlert)
        } else if !validator.isValid(email: emailTxtField.text ?? "") {
            uidelegate?.show(message: .invalidEmailAlert)
        } else if passwordTxtField.text == "" {
            uidelegate?.show(message: .passwordAlert)
        } else if conPasswordTxtField.text == "" {
            uidelegate?.show(message: .conPassAlert)
        } else if conPasswordTxtField.text != passwordTxtField.text {
            uidelegate?.show(message: .passwordMatchAlert)
        } else if nickNameTxtField.text == "" {
            uidelegate?.show(message: .nickNameAlert)
        } else if heightTxtField.text == "" {
            uidelegate?.show(message: .heightAlert)
        } else if weightTxtField.text == "" {
            uidelegate?.show(message: .weightAlert)
        } else if dobTxtField.text == "" {
            uidelegate?.show(message: .dobAlert)
        } else if genderTxtField.text == "" {
            uidelegate?.show(message: .genderAlert)
        } else {
            isVerified = true
        }
        return isVerified
    }

    //MARK:- UIButton action methods
    func setupBtnAction() {
        
        signupBtn.touchUp = { button in
            self.view.endEditing(true)
            if self.validateFields() {
                self.uidelegate?.show(message: .custom("Registration Successful"))
            }
        }
        
        dobBtn.touchUp = { button in
            let minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())
            DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: Date(), minimumDate: minimumDate, maximumDate: Date(), datePickerMode: .date) { (selectedDate) in
                let selectedDate = DateUtils.getStringFromDate(date: selectedDate ?? Date(), toFormate: DateFormat.dateMonthYear.rawValue)
                self.dobTxtField.text = selectedDate
            }
        }
        
        imageBtn.touchUp = { button in
            self.imagePickerView()
            self.imagePickerHandler = { image in
                self.profileImageView.image = image
            }
        }
        
    }
   
}
