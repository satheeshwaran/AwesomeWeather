//
//  Weather.swift
//  AwesomeWeather
//
//  Created by Satheeshwaran Jeevanandan - (Digital) on 21/05/20.
//  Copyright © 2020 Satheeshwaran Jeevanandan - (Digital). All rights reserved.
//

import Foundation

/**
 {"dt":1590008400,"main":{"temp":304.8,"feels_like":305.79,"temp_min":304.64,"temp_max":304.8,"pressure":1002,"sea_level":1001,"grnd_level":999,"humidity":58,"temp_kf":0.16},"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03n"}],"clouds":{"all":31},"wind":{"speed":5.57,"deg":227},"sys":{"pod":"n"},"dt_txt":"2020-05-20 21:00:00"}
 */

fileprivate struct RawServerResponse: Decodable {
    
    struct Main: Decodable {
        var temp: Double?
        var feels_like: Double?
        var temp_min: Double?
        var temp_max: Double?
        var pressure: Double?
        var sea_level: Double?
        var grnd_level: Double?
        var humidity: Double?
        var temp_kf: Double?
    }
    struct weatherServer: Decodable {
        var id:Double?
        var main: String?
        var icon: String?
        var description:String?
    }
    var dt: Double??
    var weather:[weatherServer]?
    var dt_txt:String?
    var main:Main?
}

struct Weather:Decodable {
    var temperature:String?
    var time:String?
    var date:String?
    var icon:String?
    var description:String?
    var humidity: String?
    init(from decoder: Decoder) throws {
        let rawResponse = try RawServerResponse(from: decoder)
        self.temperature = "\(Int(rawResponse.main?.feels_like?.rounded() ?? 0))°C"
        let dateTime = Utils.getDateTimeFromString(str: rawResponse.dt_txt)
        self.date = dateTime.1
        self.time = dateTime.0
        self.icon = rawResponse.weather?[0].icon
        self.description = rawResponse.weather?[0].description
        self.humidity = "\(Int(rawResponse.main?.humidity ?? 0))%"
    }
    
    func getWeatherIcon()->URL?{
        let icon = self.icon?.replacingOccurrences(of: "n", with: "d") //To get day icon that goes well with dark barkgrounds
        return URL.init(string:"\(Constants.WEATHER_ICON)\(icon ?? "")@2x.png")
    }
}
