//
//  ViewController.swift
//  GoFit
//

import UIKit

final class LoginVC: BaseViewController {

    //MARK:- IBOutlets
    @IBOutlet private weak var usernameTxtField: UITextField!
    @IBOutlet private weak var passwordTxtField: UITextField!
    @IBOutlet private weak var loginBtn: ActionButton!
    @IBOutlet private weak var guestLoginBtn: ActionButton!
    @IBOutlet private weak var signupBtn: ActionButton!
    
    //MARK:- Variable Declarations
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavView.backBtn.isHidden = true
        customNavView.settingBtn.isHidden = true
        setupBtnAction()
        guestLoginBtn.isHidden = true
    }
    
    //MARK:- Helper methods
    private func validateFields() -> Bool {
        var isVerified = false
        if usernameTxtField.text == "" {
            uidelegate?.show(message: .usernameAlert)
        } else if passwordTxtField.text == "" {
            uidelegate?.show(message: .passwordAlert)
        } else {
            isVerified = true
        }
        return isVerified
    }

    //MARK:- UIButton action methods
    func setupBtnAction() {
        loginBtn.touchUp = { button in
            self.view.endEditing(true)
            if self.validateFields() {
                let nextVC = DeviceListVC.instantiateFrom(storyboard: .onboarding)
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
        
        guestLoginBtn.touchUp = { button in
            let nextVC = DeviceListVC.instantiateFrom(storyboard: .onboarding)
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
        signupBtn.touchUp = { button in
            let nextVC = RegistrationVC.instantiateFrom(storyboard: .onboarding)
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
    }

}

