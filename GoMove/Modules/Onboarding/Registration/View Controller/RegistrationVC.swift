//
//  RegistrationVC.swift
//  GoMove
//

import UIKit
import DropDown

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
    @IBOutlet private weak var genderBtn: ActionButton!
    
    var isImageSelected = Bool()
    let dropDown = DropDown()
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
        if self.isImageSelected == false {
            uidelegate?.show(message: .profilePicAlert)
        }
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
                let mediaUploadManager = MediaUploadManager()
                let endpoint = UserEndpoint.registration(["username":self.emailTxtField.text,"email":self.emailTxtField.text,"password1":self.passwordTxtField.text,"password2":self.conPasswordTxtField.text,"first_name":self.nickNameTxtField.text,"last_name":"","mobile":"1234567890","nick_name":self.nickNameTxtField.text,"height":self.heightTxtField.text,"weight":self.weightTxtField.text,"date_of_birth":self.dobTxtField.text,"gender":self.genderTxtField.text?.lowercased()])
                       
                       let userImage = Media (
                           format: Media.Image.jpeg,
                           key: "profile_pic",
                        data: self.profileImageView.image?.jpegData(compressionQuality: 0.5) ?? Data()
                       )
                       
                mediaUploadManager.upload(media: userImage, at: endpoint){ [weak self] in
                switch $0 {
                case .success(let data):
                    if(data["status_code"] as? Int == 200)
                    {
                        let nextVC = DeviceListVC.instantiateFrom(storyboard: .onboarding)
                        self?.navigationController?.pushViewController(nextVC, animated: true)
                    }
                    else
                    {
                    guard let response = data["data"] as? [String:Any],
                          let result = response["result"] as? [String:Any] else {
                        if let message = data["message"] as? [String:Any]
                        {
                            if  let errorList = message.keys.first as? String {
                             if errorList.count > 0 {
                                var errorArray = message[errorList] as? [String]
                            
                                self?.uidelegate?.show(message: .custom(errorArray?.first))
                             }
                         return
                                
                            }
                        }
                        return
                    }
                    }
                        
//
                case .failure(let error):
                    self?.uidelegate?.show(message: .custom(error.errorDescription))
                }
        
            }
        }
        }
        
        
        dobBtn.touchUp = { button in
            let minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())
            DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: Date(), minimumDate: minimumDate, maximumDate: Date(), datePickerMode: .date) { (selectedDate) in
                let selectedDate = DateUtils.getStringFromDate(date: selectedDate ?? Date(), toFormate: DateFormat.yearMonthDate.rawValue)
                self.dobTxtField.text = selectedDate
            }
        }
        genderBtn.touchUp = { button in

            // The view to which the drop down will appear on
            self.dropDown.anchorView = self.genderBtn // UIView or UIBarButtonItem

            // The list of items to display. Can be changed dynamically
            self.dropDown.dataSource = ["MALE", "FEMALE"]
            self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
              print("Selected item: \(item) at index: \(index)")
                self.genderTxtField.text = item
                self.dropDown.hide()
            }

            // Will set a custom width instead of the anchor view width
            self.dropDown.show()
        }
        
        imageBtn.touchUp = { button in
            self.imagePickerView()
            self.imagePickerHandler = { image in
                self.isImageSelected = true
                self.profileImageView.image = image
            }
        }
        
    }
   
}
