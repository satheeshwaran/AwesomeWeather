//
//  WeatherTableViewCell.swift
//  AwesomeWeather
//
//  Created by Satheeshwaran Jeevanandan - (Digital) on 21/05/20.
//  Copyright © 2020 Satheeshwaran Jeevanandan - (Digital). All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    static var reuseIdentifier = "WeatherTableViewCell"
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var precipitation: UILabel!
}
