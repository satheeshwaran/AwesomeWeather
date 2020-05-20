//
//  NetworkManager.swift
//  AwesomeWeather
//
//  Created by Satheeshwaran Jeevanandan - (Digital) on 20/05/20.
//  Copyright © 2020 Satheeshwaran Jeevanandan - (Digital). All rights reserved.
//

import Foundation
import Alamofire

struct NetworkManager {
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
