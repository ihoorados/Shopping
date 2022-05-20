//
//  FilterView.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 20/5/2022.
//

import UIKit

/* ////////////////////////////////////////////////////////////////////// */
// MARK: FilterView Output
/* ////////////////////////////////////////////////////////////////////// */

protocol FilterViewOutput: AnyObject {

    func filterDataBy(category: Categories, value: Bool)
}


class FilterView: UIView {

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Dependency Injection
    /* ////////////////////////////////////////////////////////////////////// */

    weak var delegate: FilterViewOutput?

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

    @IBOutlet weak var filterBooksSwitch: UISwitch!
    @IBOutlet weak var filterSportSwitch: UISwitch!
    @IBOutlet weak var filterMusicSwitch: UISwitch!
    @IBOutlet weak var filterTravelSwitch: UISwitch!
    @IBOutlet weak var filterElectronicsSwitch: UISwitch!
    @IBOutlet weak var filterOtherSwitch: UISwitch!

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Private Functions
    /* ////////////////////////////////////////////////////////////////////// */

    /// Init setup
    fileprivate func initSetup(){

        Bundle.main.loadNibNamed("FilterView", owner: self, options: nil)
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


    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Public Functions
    /* ////////////////////////////////////////////////////////////////////// */

    func updateSwitch(categories: [Categories]){

        categories.forEach { category in

            switch category {
            case .books:

                self.filterBooksSwitch.setOn(true, animated: true)
                break
            case .music:

                self.filterMusicSwitch.setOn(true, animated: true)
                break
            case .sport:

                self.filterSportSwitch.setOn(true, animated: true)
                break
            case .travel:

                self.filterTravelSwitch.setOn(true, animated: true)
                break
            case .electronics:

                self.filterElectronicsSwitch.setOn(true, animated: true)
                break
            default:

                self.filterOtherSwitch.setOn(true, animated: true)
                break
            }
        }
    }

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: UIEvent
    /* ////////////////////////////////////////////////////////////////////// */

    // Switch Action
    @IBAction func switchsAction(_ sender: UIButton) {

        switch sender {
        case self.filterBooksSwitch:

            self.delegate?.filterDataBy(category: .books, value: self.filterBooksSwitch.isOn)
            break
        case self.filterMusicSwitch:

            self.delegate?.filterDataBy(category: .music, value: self.filterMusicSwitch.isOn)
            break
        case self.filterSportSwitch:

            self.delegate?.filterDataBy(category: .sport, value: self.filterSportSwitch.isOn)
            break
        case self.filterTravelSwitch:

            self.delegate?.filterDataBy(category: .travel, value: self.filterTravelSwitch.isOn)
            break
        case self.filterElectronicsSwitch:

            self.delegate?.filterDataBy(category: .electronics, value: self.filterElectronicsSwitch.isOn)
            break
        default:

            self.delegate?.filterDataBy(category: .other, value: self.filterOtherSwitch.isOn)
            break
        }
    }

    @objc func removeUIControllAction(_ sender: Any){

        UIView.animate(withDuration: 0.3, delay: 0.0, options: .allowAnimatedContent) {
            self.alpha = 0
        }completion: { valid in
            self.removeFromSuperview()
        }
    }
}
