//
//  UIViewController+Extension.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 20/5/2022.
//

import Foundation
import UIKit

enum Navigation {
    case right
    case left
    case bottom
    case top
    case fade
}

extension UIViewController{

    /// This function add `view` to `vc` with .
    ///
    /// - Parameter view: The View that add to ViewController.
    /// - Parameter navigationTo: The Animation Navigation in view to add child VC.
    func addViewToViewController(view: UIView, navigation: Navigation){

        switch navigation{
            case .right:
                view.center.x -= self.view.frame.width
            case .left:
                view.center.x += self.view.frame.width
            case .top:
                view.center.y += self.view.frame.height
            case .bottom:
                view.center.y -= self.view.frame.height
            case .fade:
                view.alpha = 0
        }

        UIView.animate(withDuration: 0.33, delay: 0.0,
                       options: [.allowUserInteraction,.allowAnimatedContent]) {
            self.view.addSubview(view)
            switch navigation{
                case .right:
                    view.center.x += self.view.frame.width
                case .left:
                    view.center.x -= self.view.frame.width
                case .top:
                    view.center.y -= self.view.frame.height
                case .bottom:
                    view.center.y += self.view.frame.height
                case .fade:
                    view.alpha = 1
            }
        }
    }
}
