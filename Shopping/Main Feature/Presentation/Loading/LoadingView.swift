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

    /// Init setup
    fileprivate func initSetup(){

        self.setupUIView()
    }

    fileprivate func setupUIView(){

    }

}
