//
//  ResetPasswordVC.swift
//  GoMove
//
//  Created by apple on 16/09/21.
//

import UIKit

class ResetPasswordVC: BaseViewController {

    @IBOutlet private weak var emailTxtField: UITextField!
    @IBOutlet private weak var passwordTxtField: UITextField!
    @IBOutlet private weak var confirmPasswordTxtField: UITextField!
    @IBOutlet private weak var submitBtn: ActionButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBtnAction()
        customNavView.settingBtn.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Helper methods
    private func validateFields() -> Bool {
        var isVerified = false
        
        if emailTxtField.text == "" {
            uidelegate?.show(message: .emailAlert)
        } else if (passwordTxtField.text == "")
        {
            uidelegate?.show(message: .passwordAlert)
        }
        else if (confirmPasswordTxtField.text == "")
        {
            uidelegate?.show(message: .conPassAlert)
        }
        else if (passwordTxtField.text != confirmPasswordTxtField.text)
        {
            uidelegate?.show(message: .passwordMatchAlert)
        }
        
        else {
            isVerified = true
        }
        return isVerified
    }
    
    func setupBtnAction() {
        
        submitBtn.touchUp = { button in
            self.view.endEditing(true)
            if self.validateFields() {
                
                
                    self.requestAPI(endpoint: UserEndpoint.resetPassword(["email":self.emailTxtField.text ?? "","new_password1":self.passwordTxtField.text ?? "","new_password2":self.confirmPasswordTxtField.text ?? ""])) { response in
                        DispatchQueue.main.async {
                            if(response["error"] as? Bool == false)
                            {
                                if(response["status_code"] as? Int == 200)
                                {
                                    print("test")
//                                    let nextVC = DeviceListVC.instantiateFrom(storyboard: .onboarding)
//                                    self.navigationController?.pushViewController(nextVC, animated: true)
                                }
                                else
                                {
                                guard let data = response["data"] as? [String:Any],
                                      let result = response["result"] as? [String:Any] else {
                                    return
                                }
                                }
                            }
                            else
                            {
                                self.uidelegate?.show(message: .custom(response["message"] as? String))
                            }
                            }
                    }
                }
               
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
