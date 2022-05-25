//
//  LoadingView.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 23/5/2022.
//

import UIKit

protocol LoadingView: AnyObject {
    
    func startAnimate()
}

class LoadingViewImpl: UIView {

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Dependency Injection
    /* ////////////////////////////////////////////////////////////////////// */

    weak var delegate: LoadingView?

    override init(frame: CGRect){
        super.init(frame: frame)

        self.initSetup()
    }

    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)

        self.initSetup()
    }

    lazy var titleLabel: UILabel = {

        let label = UILabel()
        label.text = "Fetching ..."
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        label.textAlignment = .center
        return label
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {

        let ac = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        ac.tintColor = .gray
        return ac
    }()

    /// Init setup
    fileprivate func initSetup(){

        self.setupUIView()
        self.setupUILayout()
    }

    fileprivate func setupUIView(){

        self.addSubview(self.titleLabel)
        self.addSubview(self.activityIndicator)
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.shadowOffset = CGSize(width: 5,
                                          height: 5)
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.3
        self.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    }

    fileprivate func setupUILayout(){

        self.titleLabel.anchor(top: self.topAnchor,
                               left: self.leftAnchor,
                               right: self.rightAnchor,
                               paddingTop: 16)
        self.activityIndicator.anchor(top: self.titleLabel.bottomAnchor,
                                      paddingTop: 16)
        self.activityIndicator.centerX(inView: self)
        self.activityIndicator.startAnimating()

    }

}
