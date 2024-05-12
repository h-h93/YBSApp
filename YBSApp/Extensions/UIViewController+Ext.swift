//
//  UIViewController+Ext.swift
//  YBSApp
//
//  Created by hanif hussain on 10/05/2024.
//

import UIKit

extension UIViewController {
    func presentYBSAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = YBSAlertControllerVC(title: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
}

