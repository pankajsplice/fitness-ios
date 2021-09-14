//
//  CustomNavigationView.swift
//  Addison Clifton
//


import UIKit

class CustomNavigationView: UIView {
    
    //MARK:- IBOutlets
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backBtn: ActionButton!
    @IBOutlet weak var settingBtn: ActionButton!
    @IBOutlet weak var logoBtn: ActionButton!
    

    override init(frame: CGRect) { //For using custom view in code
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { //For using custom view in IB
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CustomNavigationView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}
