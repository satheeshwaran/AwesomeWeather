//
//  WeatherManager.swift
//  AwesomeWeather
//
//  Created by Satheeshwaran Jeevanandan - (Digital) on 20/05/20.
//  Copyright © 2020 Satheeshwaran Jeevanandan - (Digital). All rights reserved.
//

import Foundation
import CoreLocation


/// WeatherManager is the interface through which the viewmodel will get the weather data from.
class WeatherManager{
    typealias WeatherCompletion = (_ response: Forecast?, _ error: Error?)->()
    private static var shared:WeatherManager!
    private static var userChoiceKeyName = "LOCATION_CHOSEN"
    private enum RequestType:Int{
        case city=1
        case coordinates=2
    }
    
    static func sharedInstance()->WeatherManager{
        if(WeatherManager.shared == nil){
            WeatherManager.shared = WeatherManager()
        }
        return WeatherManager.shared
    }
    
    func saveWeathreLocation(userchoise: UserSelection){
        if let data = try? JSONEncoder().encode(userchoise) {
            UserDefaults.standard.set(data, forKey: WeatherManager.userChoiceKeyName)
        }
    }
    
    func retriveWeatherLocation()->UserSelection?{
        if let data = UserDefaults.standard.value(forKey: WeatherManager.userChoiceKeyName) as? Data, let userSelection = try? JSONDecoder().decode(UserSelection.self, from: data) {
            return userSelection
        }
        return nil
    }
    
    func getWeatherForLong(coordinates: CLLocationCoordinate2D, results: @escaping WeatherCompletion) {
        self.makeAPICall(url: generateRequestURL(type: .coordinates, params: coordinates), params: nil, results: results)
    }
    
    func getWeatherForPlace(place: String, results: @escaping WeatherCompletion) {
        self.makeAPICall(url: generateRequestURL(type: .city, params: place), params: nil, results: results)
    }
    
    func makeAPICall(url:String, params: [String:AnyObject]?, results: @escaping WeatherCompletion){
        NetworkManager.GET(URL:url) { (response, error) in
            if let data = response{
                do{
                    let forecast = try JSONDecoder().decode(Forecast.self, from: data)
                    print(forecast)
                    return results(forecast, nil)
                }
                catch let err{
                    return results(nil, err)
                }
            }
            else{
                results(nil,error)
            }
        }
    }
    
    private func generateRequestURL(type:RequestType, params:Any?)->String{
        var requestURL = Constants.REMOTE_ENDPOINT
        switch type {
        case .city:
            if let city = params as? String {
                requestURL += "\(Constants.FORECAST_SERVICE_CITY)\(city)"
            }
        case .coordinates:
            if let coordinates = params as? CLLocationCoordinate2D {
                requestURL += "\(Constants.FORECAST_SERVICE)\(Constants.LAT_PARAM)=\(coordinates.latitude)&\(Constants.LONG_PARAM)=\(coordinates.longitude)"
            }
        }
        return appendAPIKEY(str: requestURL)
    }
    
    private func appendAPIKEY(str:String)->String{
        return "\(str)\(Constants.APPID_PARAM)\(Constants.API_KEY)"
    }
}
