//
//  LocationManager.swift
//  AwesomeWeather
//
//  Created by Satheeshwaran Jeevanandan - (Digital) on 21/05/20.
//  Copyright © 2020 Satheeshwaran Jeevanandan - (Digital). All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class LocationManger:NSObject,CLLocationManagerDelegate{
    
    private var clManager:CLLocationManager!
    private var locationHandler:((CLLocation)->())? = nil
    
    func initializeWithHandler(handler:@escaping (CLLocation)->()) {
        self.clManager = CLLocationManager()
        self.locationHandler = handler
        self.clManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let callback = locationHandler, let location = locations.last {
            callback(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showAlert(message: error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways,.authorizedWhenInUse:
            getCurrentLocation()
        default: break
        }
    }
    
    func checkAndrequestPermission()->Bool{
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways,.authorizedWhenInUse:
            return true
        default:
            self.requestLocationPermission()
            //            showAlert(message: "Location permission not available, please grant.")
        }
        return false
    }
    
    func requestLocationPermission(){
        clManager.requestAlwaysAuthorization()
    }
    
    func getCurrentLocation(){
        if(checkAndrequestPermission()){
            clManager.requestLocation()
        }
    }
    
    func checkLocationServicesAndSuggest()->Bool{
        if(CLLocationManager.locationServicesEnabled()){
            return true;
        }else{
            //SHOW ALERT
            showAlert(message: "Kindly enable location services in settings")
        }
        return false;
    }
    
    func showAlert(title:String = "Alert", message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        if let tabBarController = rootViewController as? UITabBarController {
            rootViewController = tabBarController.selectedViewController
        }
        rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
