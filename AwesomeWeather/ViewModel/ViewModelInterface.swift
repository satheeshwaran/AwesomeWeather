//
//  ViewModelInterface.swift
//  AwesomeWeather
//
//  Created by Satheeshwaran Jeevanandan - (Digital) on 21/05/20.
//  Copyright © 2020 Satheeshwaran Jeevanandan - (Digital). All rights reserved.
//

import Foundation

/// Interface for ViewModels and Views to update each other.
@objc protocol ViewModelInterface {
    
    /// Compulsory method that will be trigerred when there are updates to the model.
    func didUpdate()
    
    /// Compulsory methot that will be trigerred when there is an error situation. Houston we need help.
    ///
    /// - Parameter error: The error message.
    func didError(error: String)
    
    /// Compulsory method that will be triggered when there is a network error.
    func onNetworkError()

}
