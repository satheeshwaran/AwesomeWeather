//
//  UIViewController+Alert.swift
//  AwesomeWeather
//
//  Created by Satheeshwaran Jeevanandan - (Digital) on 21/05/20.
//  Copyright © 2020 Satheeshwaran Jeevanandan - (Digital). All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlert(title: String = "Alert", message: String) {
        let alertController = UIAlertController(title:title , message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil )
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
