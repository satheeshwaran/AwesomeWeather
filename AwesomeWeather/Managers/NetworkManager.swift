//
//  NetworkManager.swift
//  AwesomeWeather
//
//  Created by Satheeshwaran Jeevanandan - (Digital) on 20/05/20.
//  Copyright © 2020 Satheeshwaran Jeevanandan - (Digital). All rights reserved.
//

import Foundation
import Alamofire

/// NetworkManager manages all API calls going out of the API.
struct NetworkManager {
    
    /// Method to make a HTTP GET CALL
    /// - Parameters:
    ///   - URL: The URL with query params
    ///   - completionHandler: compeltion handeler where the response in deliverd.
    static func GET(URL:String!, completionHandler: @escaping (_ response:Data?, _ error:Error?) -> ()){
        AF.request(URL).response { response in
            debugPrint(response)
            if let err = response.error{
                completionHandler(nil, err)
            }else{
                completionHandler(response.data, nil)
            }
        }
    }
}
