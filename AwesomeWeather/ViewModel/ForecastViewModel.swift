//
//  WeatherViewModel.swift
//  AwesomeWeather
//
//  Created by Satheeshwaran Jeevanandan - (Digital) on 21/05/20.
//  Copyright © 2020 Satheeshwaran Jeevanandan - (Digital). All rights reserved.
//

import Foundation
import CoreLocation

class ForecastViewModel {
    private(set) var forecast:Forecast?{
        didSet {
            updateCallBack?.didUpdate()
        }
    }
    private weak var updateCallBack: ViewModelInterface?
    
    init(interface: AnyObject & ViewModelInterface) {
        updateCallBack = interface
    }
    
    func get(index: Int) -> Weather? {
        if let forecastList = forecast?.forecastList{
            return forecastList[index]
        }
        return nil
    }
    
    func getWeatherForCity(city:String) {
        WeatherManager.sharedInstance().getWeatherForPlace(place: city) { [weak self] (response,error)  in
            if(error == nil){
                self?.forecast = response
            }else{
                self?.updateCallBack?.didError(error: error?.localizedDescription ?? "Something went wrong")
            }
        }
    }
    
    func getWeatherForCoordinates(location: CLLocationCoordinate2D) {
        WeatherManager.sharedInstance().getWeatherForLong(coordinates: location) {[weak self](response,error) in
            if(error == nil){
                self?.forecast = response
            }else{
                self?.updateCallBack?.didError(error: error?.localizedDescription ?? "Something went wrong")
            }
        }
    }
}
