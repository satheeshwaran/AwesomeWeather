//
//  UserSelection.swift
//  AwesomeWeather
//
//  Created by Satheeshwaran Jeevanandan - (Digital) on 22/05/20.
//  Copyright © 2020 Satheeshwaran Jeevanandan - (Digital). All rights reserved.
//

import Foundation

struct UserSelection:Decodable,Encodable {
    var placeName:String?
    var latitude:Double?
    var longitude:Double?
}
