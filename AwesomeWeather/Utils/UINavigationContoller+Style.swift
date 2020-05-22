//
//  UINavigationContoller+Style.swift
//  AwesomeWeather
//
//  Created by Satheeshwaran Jeevanandan - (Digital) on 22/05/20.
//  Copyright © 2020 Satheeshwaran Jeevanandan - (Digital). All rights reserved.
//

import Foundation
import UIKit


extension UINavigationController{
    
    /// Method to set styles for Weather Home
    func setWeatherHomeNavStyle(){
        self.navigationBar.isHidden = false
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = .clear
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19)]

    }
}
