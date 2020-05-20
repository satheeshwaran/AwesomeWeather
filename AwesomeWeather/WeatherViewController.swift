//
//  WeatherViewController.swift
//  AwesomeWeather
//
//  Created by Satheeshwaran Jeevanandan - (Digital) on 21/05/20.
//  Copyright © 2020 Satheeshwaran Jeevanandan - (Digital). All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    var location:CLLocationCoordinate2D?
    var placeName:String?
    var weatherData:[String:AnyObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let place = placeName{
            getWeatherForCity(city: place)
        }else{
            getWeatherForCoordinates()
        }
        // Do any additional setup after loading the view.
    }
    
    func getWeatherForCity(city:String) {
        WeatherManager.sharedInstance().getWeatherForPlace(place: city) { [weak self] (response) in
            self?.weatherData = response
        }
    }
    
    func getWeatherForCoordinates() {
        if let loc = location{
            WeatherManager.sharedInstance().getWeatherForLong(coordinates: loc) { [weak self] (response) in
                self?.weatherData = response
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
