//
//  ViewController.swift
//  AwesomeWeather
//
//  Created by Satheeshwaran Jeevanandan - (Digital) on 20/05/20.
//  Copyright © 2020 Satheeshwaran Jeevanandan - (Digital). All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    private var lManager = LocationManger()
    private var currentLocation:CLLocation?
    private var placeName:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        lManager.initializeWithHandler { [weak self] (location) in
            self?.currentLocation = location
            print("location recieved--> latitude \(location.coordinate.latitude) longitude \(location.coordinate.longitude)")
            self?.performSegue(withIdentifier: "WeatherHome", sender: self)
        }
    }

    @IBAction func autoDetectTapped(_ sender: Any) {
        lManager.getCurrentLocation()
    }
    
    @IBAction func enterManualTapped(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WeatherHome" {
            if let destinationVC = segue.destination as? WeatherViewController {
                destinationVC.location = currentLocation?.coordinate
                destinationVC.placeName = placeName
            }
        }
    }
}

