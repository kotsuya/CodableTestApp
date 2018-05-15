//
//  UIAlertController+.swift
//  CodableTestApp
//
//  Created by YooSeunghwan on 2018/05/02.
//  Copyright © 2018年 Yoo. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    class func showIndicatorAlert(_ viewController: UIViewController, message: String) {
        let alert: UIAlertController = self.init(title: nil, message: message, preferredStyle: .alert)
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.center = CGPoint(x: 30, y: 30)
        alert.view.addSubview(indicator)
        
        indicator.startAnimating()
        viewController.present(alert, animated: true) { () -> Void in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                viewController.dismiss(animated: true, completion: nil)
            }
        }
    }
}

