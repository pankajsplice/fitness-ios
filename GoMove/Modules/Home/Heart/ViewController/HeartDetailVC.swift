//
//  HeartDetailVC.swift
//  GoMove
//


import UIKit

final class HeartDetailVC: BaseViewController {

    //MARK:- IBOutlets
    @IBOutlet private weak var heartCollectionView: UICollectionView!
    @IBOutlet private weak var weekDatesLbl: UILabel!
    @IBOutlet private weak var previousWeekAction: ActionButton!
    @IBOutlet private weak var nextWeekAction: ActionButton!
    
    //MARK:- Variable Declarations
    var selectedIndex = 2
    
    //Dates
    var weekEndDate = Date()
    var weekStartDate = Date()
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        heartCollectionView.isHidden = true
        let completeDate = setDatesForSevenDays(weekLastDate: Date().startOfDay)
        weekDatesLbl.text = "\(completeDate.0) - \(completeDate.1)"
        setupBtnAction()
    }
    
    //MARK:- Helper methods
    //Setup Date range
    private func setDatesForSevenDays(weekLastDate: Date) -> (String,String) {
        weekEndDate = weekLastDate
        weekStartDate = weekEndDate.add(component: .day, value: -6)
        let weekEndDateValue = DateUtils.getStringFromDateNew(date: weekEndDate)
        let weekStartDateValue = DateUtils.getStringFromDateNew(date: weekStartDate)
        return (weekStartDateValue,weekEndDateValue)
    }
    
    //MARK:- UIButton action methods
    private func setupBtnAction() {

        previousWeekAction.touchUp = { button in
            let completeDate = self.setDatesForSevenDays(weekLastDate: self.weekStartDate.add(component: .day, value: -1))
            self.weekDatesLbl.text = "\(completeDate.0) - \(completeDate.1)"
        }
        
        nextWeekAction.touchUp = { button in
            if self.weekEndDate != Date().startOfDay {
                let completeDate = self.setDatesForSevenDays(weekLastDate: self.weekEndDate.add(component: .day, value: 7))
                self.weekDatesLbl.text = "\(completeDate.0) - \(completeDate.1)"
            }
        }
    }
}

//MARK:- UICollectionViewDelegate, UICollectionViewDataSource methods
extension HeartDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = HeartRateCollectionCell.dequeReusably(for: collectionView, at: indexPath)
        cell.heartRangeLbl.text = Constants.DummyArray.heartRateRangeArray[indexPath.item]
        if indexPath.item == selectedIndex {
            cell.heartRangeView.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.01568627451, blue: 0.4196078431, alpha: 1)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: heartCollectionView.frame.size.width / 5, height: 45)
    }
    
    
}
