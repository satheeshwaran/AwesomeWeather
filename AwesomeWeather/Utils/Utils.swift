//
//  Utils.swift
//  AwesomeWeather
//
//  Created by Satheeshwaran Jeevanandan - (Digital) on 21/05/20.
//  Copyright © 2020 Satheeshwaran Jeevanandan - (Digital). All rights reserved.
//

import Foundation

/// Generic utility methods
struct Utils {
    
    /// Method to get displayable date and time string from a date string
    /// - Parameter str: Date string.
    static func getDateTimeFromString(str:String?)->(time: String?,Date: String?){
        if let value = str{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let date = formatter.date(from: value){
                //2020-05-20 21:00:00
                formatter.dateFormat = "h a"
                let hour = formatter.string(from: date)
                formatter.dateFormat = "dd/MM"
                let day = formatter.string(from: date)
                return(hour,day)
//                let calendar = Calendar.current
//                return("\(calendar.component(.hour, from: date)):\(calendar.component(.minute, from: date))","\(calendar.component(.day, from: date))///\(calendar.component(.day, from: date))")
            }
        }
        return("","")
        
    }
}
