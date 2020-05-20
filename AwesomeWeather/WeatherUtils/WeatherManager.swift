//
//  WeatherManager.swift
//  AwesomeWeather
//
//  Created by Satheeshwaran Jeevanandan - (Digital) on 20/05/20.
//  Copyright © 2020 Satheeshwaran Jeevanandan - (Digital). All rights reserved.
//

import Foundation
import CoreLocation

/*
 {"coord":{"lon":80.28,"lat":13.09},"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03n"}],"base":"stations","main":{"temp":306.02,"feels_like":311.69,"temp_min":305.93,"temp_max":306.15,"pressure":1003,"humidity":70},"visibility":6000,"wind":{"speed":2.6,"deg":210},"clouds":{"all":40},"dt":1589992293,"sys":{"type":1,"id":9218,"country":"IN","sunrise":1589933548,"sunset":1589979519},"timezone":19800,"id":1264527,"name":"Chennai","cod":200}
 */

class WeatherManager{
    private static var shared:WeatherManager!
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
    
    func saveWeathreLocation(){
        
    }
    
    func retriveWeatherLocation(){
        
    }
    
    func getWeatherForLong(coordinates: CLLocationCoordinate2D) {
        NetworkManager.GET(URL: generateRequestURL(type: .coordinates, params: coordinates)) { (response, error) in
            
        }
    }
    
    func getWeatherForPlace(place: String, results: @escaping (_ response: [String:AnyObject])->()) {
        NetworkManager.GET(URL: generateRequestURL(type: .city, params: place)) { (response, error) in
            if let data = response{
                do {
                    if let parsedResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]{
                        return results(parsedResponse)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            results([:])
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
                requestURL += "\(Constants.FORECAST_SERVICE_LOC)\(Constants.LAT_PARAM)=\(coordinates.latitude)\(Constants.LONG_PARAM)=\(coordinates.longitude)"
            }
        }
        return appendAPIKEY(str: requestURL)
    }
    
    private func appendAPIKEY(str:String)->String{
        return "\(str)\(Constants.APPID_PARAM)\(Constants.API_KEY)"
    }
}
