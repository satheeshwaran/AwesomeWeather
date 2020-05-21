//
//  WeatherIcon+ImageVIew.swift
//  AwesomeWeather
//
//  Created by Satheeshwaran Jeevanandan - (Digital) on 21/05/20.
//  Copyright © 2020 Satheeshwaran Jeevanandan - (Digital). All rights reserved.
//

import Foundation
import UIKit

/*
 https://medium.com/@matthew_healy/loading-images-in-ios-without-dependencies-aff1555dbf1e
 */

extension UIImageView {
    
    /// Method to load image to a UIImageView from the internet.
    /// - Parameters:
    ///   - url: The URL of the remote image.
    ///   - placeholder: placeHolder image if any.
    func setImage(from url: URL, withPlaceholder placeholder: UIImage? = nil) {
        self.image = placeholder
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}
