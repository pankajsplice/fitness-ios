//
//  DashboardVC.swift
//  GoMove
//

import UIKit

final class DashboardVC: BaseViewController {

    //MARK:- IBOutlets
    @IBOutlet private weak var stepsCountLbl: UILabel!
    @IBOutlet private weak var heartRateCountLbl: UILabel!
    @IBOutlet private weak var activityCountLbl: UILabel!
    @IBOutlet private weak var bloodaPressureLbl: UILabel!
    @IBOutlet private weak var sleepLbl: UILabel!
    @IBOutlet private weak var stepsBtn: ActionButton!
    @IBOutlet private weak var heartBtn: ActionButton!
    @IBOutlet private weak var activityBtn: ActionButton!
    @IBOutlet private weak var bloodBtn: ActionButton!
    @IBOutlet private weak var sleepBtn: ActionButton!
    
    //MARK:- Variable Declarations
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavView.logoBtn.isHidden = false
    }
    
    //MARK:- Helper methods
    
    
    //MARK:- UIButton action methods
    @IBAction private func selectModuleAction(_ sender: UIButton) {
        switch sender {
        case stepsBtn:
            let nextVC = StepsDetailVC.instantiateFrom(storyboard: .home)
            self.navigationController?.pushViewController(nextVC, animated: true)
            break
        case heartBtn:
            let nextVC = HeartDetailVC.instantiateFrom(storyboard: .home)
            self.navigationController?.pushViewController(nextVC, animated: true)
            break
        case activityBtn:
            let nextVC = ActivityDetailVC.instantiateFrom(storyboard: .home)
            self.navigationController?.pushViewController(nextVC, animated: true)
            break
        case bloodBtn:
            let nextVC = BloodPressureDetailVC.instantiateFrom(storyboard: .home)
            self.navigationController?.pushViewController(nextVC, animated: true)
            break
        case sleepBtn:
            let nextVC = SleepDetailVC.instantiateFrom(storyboard: .home)
            self.navigationController?.pushViewController(nextVC, animated: true)
            break
        default:
            break
        }
    }

}
