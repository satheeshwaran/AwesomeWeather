//
//  Forecast.swift
//  AwesomeWeather
//
//  Created by Satheeshwaran Jeevanandan - (Digital) on 21/05/20.
//  Copyright © 2020 Satheeshwaran Jeevanandan - (Digital). All rights reserved.
//

import Foundation

fileprivate struct RawServerResponse: Decodable {
    var list: [Weather]
    struct Coordinates: Decodable {
        var lat: Double?
        var lon: Double?
    }
    struct City: Decodable {
        var id:Double?
        var name: String?
        var coord:Coordinates
        var country: String?
        var population: Double?
        var timezone: Double?
        var sunrise: Double?
        var sunset: Double?
    }
    var message:Int?
    var cnt:Int?
    var city:City?
}

struct Forecast:Decodable {
    var forecastList:[Weather]?
    var cityName: String?
    init(from decoder: Decoder) throws {
        let rawResponse = try RawServerResponse(from: decoder)
        self.forecastList = rawResponse.list
        if let city = rawResponse.city?.name{
            self.cityName = city
        }
    }
}
