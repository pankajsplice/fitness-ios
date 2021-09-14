//
//  ProfileSettingVC.swift
//  GoMove
//

import UIKit

final class ProfileSettingVC: BaseViewController {

    //MARK:- IBOutlets
    @IBOutlet private weak var updateProfileBtn: ActionButton!
    @IBOutlet private weak var nickNameTxtField: UITextField!
    @IBOutlet private weak var heightTxtField: UITextField!
    @IBOutlet private weak var weightTxtField: UITextField!
    @IBOutlet private weak var dobTxtField: UITextField!
    @IBOutlet private weak var genderTxtField: UITextField!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var imageBtn: ActionButton!
    @IBOutlet private weak var dobBtn: ActionButton!
    
    //MARK:- Variable Declarations
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
        setupBtnAction()
        customNavView.settingBtn.isHidden = true
    }
    
    //MARK:- Helper methods
    private func validateFields() -> Bool {
        var isVerified = false
        if nickNameTxtField.text == "" {
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
        
        updateProfileBtn.touchUp = { button in
            self.view.endEditing(true)
            if self.validateFields() {
                self.uidelegate?.show(message: .custom("Profile updated"))
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
