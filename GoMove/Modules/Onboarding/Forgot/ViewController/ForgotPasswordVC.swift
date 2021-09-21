//
//  ForgotPasswordVC.swift
//  GoMove
//
//  Created by apple on 15/09/21.
//

import UIKit

class ForgotPasswordVC: BaseViewController {

    //MARK:- IBOutlets
    @IBOutlet private weak var emailTxtField: UITextField!
    @IBOutlet private weak var otpTxtField: UITextField!
    @IBOutlet private weak var submitBtn: ActionButton!
    @IBOutlet private weak var pwdView: UIView!
    
    var otpStatus = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBtnAction()
        customNavView.settingBtn.isHidden = true
        self.pwdView.isHidden = true
        // Do any additional setup after loading the view.
    }
    

    //MARK:- Helper methods
    private func validateFields(otpStatus : Bool) -> Bool {
        var isVerified = false
        
        if emailTxtField.text == "" {
            uidelegate?.show(message: .emailAlert)
        } else if (otpTxtField.text == "" && otpStatus == true)
        {
            uidelegate?.show(message: .emailAlert)
        }
        else {
            isVerified = true
        }
        return isVerified
    }
    
    
    func setupBtnAction() {
        
        submitBtn.touchUp = { button in
            self.view.endEditing(true)
            if self.validateFields(otpStatus: self.otpStatus) {
                
                if(!self.otpStatus)
                {
                self.requestAPI(endpoint: UserEndpoint.forgotPassword(["email":self.emailTxtField.text ?? ""])) { response in
                    DispatchQueue.main.async {
                        if(response["error"] as? Bool == false)
                        {
                            if(response["status_code"] as? Int == 200)
                            {
                                self.otpStatus = true
                                self.pwdView.isHidden = false
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
                else{
                    self.requestAPI(endpoint: UserEndpoint.otpVerify(["email":self.emailTxtField.text ?? "","otp":self.otpTxtField.text ?? ""])) { response in
                        DispatchQueue.main.async {
                            if(response["error"] as? Bool == false)
                            {
                                if(response["status_code"] as? Int == 200)
                                {
                                    let nextVC = ResetPasswordVC.instantiateFrom(storyboard: .onboarding)
                                    self.navigationController?.pushViewController(nextVC, animated: true)
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
