//
//  SortView.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 20/5/2022.
//

import Foundation
import UIKit

class SortView: UIView {

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Dependency Injection
    /* ////////////////////////////////////////////////////////////////////// */

    override init(frame: CGRect){
        super.init(frame: frame)

        self.initSetup()
    }

    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)

        self.initSetup()
    }

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: IBOutlet
    /* ////////////////////////////////////////////////////////////////////// */

    @IBOutlet weak var contentView:UIView!
    @IBOutlet weak var removeUIControll:UIControl!
    @IBOutlet weak var baseView:UIView!

    @IBOutlet weak var sortNameSwitch: UISwitch!
    @IBOutlet weak var sortPriceSwitch: UISwitch!


    /// Init setup
    fileprivate func initSetup(){

        Bundle.main.loadNibNamed("SortView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        contentView.tag = 2
        contentView.backgroundColor = .clear

        baseView.layer.cornerRadius = 12.0
        baseView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]


        self.setupUIView()
        self.setupUIEvent()
        self.bindingViewModel()


        UIView.animate(withDuration: 0.3, delay: 0.3, options: .allowAnimatedContent) {

            self.removeUIControll.alpha = 0.4
        }
    }

    fileprivate func bindingViewModel(){

    }

    fileprivate func setupUIView(){

    }

    fileprivate func setupUIEvent(){

        self.removeUIControll.addTarget(self, action: #selector(self.removeUIControllAction), for: .touchUpInside)
    }

    @objc func removeUIControllAction(_ sender: Any){

        UIView.animate(withDuration: 0.3, delay: 0.0, options: .allowAnimatedContent) {
            self.alpha = 0
        }completion: { valid in
            self.removeFromSuperview()
        }
    }
}
