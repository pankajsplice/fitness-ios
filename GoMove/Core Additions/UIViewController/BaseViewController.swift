//
//  BaseViewController.swift
//  Addison Clifton
//


import UIKit
import Photos

class BaseViewController: UIViewController {

    //MARK:- IBoutlets
    @IBOutlet weak var customNavView: CustomNavigationView!
    
    //MARK:- Variable Declaration
    var validator = Validator()
    weak var uidelegate: UIDelegate?
    var imagePickerHandler: ((UIImage) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavView.logoBtn.isHidden = true
        uidelegate = self
        setSettingButton()
        setBackButton()
    }
    
    //MARK:- Helper Methods
    func setupNavigation(title: String) {
        self.setBackButton()
    }
    
    func setBackButton() {
        customNavView.backBtn.touchUp = { [self] button in
            navigationController?.popViewController(animated: true)
        }
    }
    
    func setSettingButton() {
        customNavView.settingBtn.touchUp = { button in
            //TODO:- Navigate to setting screen
            let nextVC = ProfileSettingVC.instantiateFrom(storyboard: .onboarding)
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
}

extension BaseViewController: UIDelegate {
    func show(message: AlertMessages) {
        DispatchQueue.main.async {
            self.showAlertViewWith(message: message, buttons: .ok(nil))
        }
    }
}

//MARK:- API Calling
extension BaseViewController {
    func requestAPI(endpoint: UserEndpoint, completion: @escaping ([String: Any]) -> Void) {
        endpoint.request { [weak self] in
            switch $0 {
            case .success(let data):
                guard let response = data as? [String: Any] else { return }
                completion(response)
            case .failure(let error):
                self?.show(message: .custom(error.errorDescription))
            }
        }
    }
}


//MARK:- Camera/Photo Library
extension BaseViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerView() {
        let pickerAlert = UIAlertController (title: "Select Option", message: "", preferredStyle: .actionSheet)
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        pickerAlert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (UIAlertAction) in
            pickerAlert.dismiss(animated: true, completion: {
                imagePickerController.allowsEditing = true
                imagePickerController.sourceType = .photoLibrary
            })
            self.present(imagePickerController,animated: true,completion: nil)
        }))
        pickerAlert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(UIAlertAction) in
            self.openCamera()
        }))
        pickerAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(UIAlertAction) in
            
        }))
        //For ipad
        if let popoverController = pickerAlert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        self.present(pickerAlert,animated: true,completion: {
            
        })
    }
    
    func openCamera(){
            let imagePicker = UIImagePickerController()
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
            {
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
            else
            {
                let alert  = UIAlertController(title: "Warning", message: "You don't have camera.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        //didFinishPickingMediaWithInfo
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let selectedImage = info[.originalImage] as? UIImage else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            }
            self.imagePickerHandler!(selectedImage)
            dismiss(animated: true, completion: nil)
        }
    
}
