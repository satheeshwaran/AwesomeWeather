//
//  ViewController.swift
//  AwesomeWeather
//
//  Created by Satheeshwaran Jeevanandan - (Digital) on 20/05/20.
//  Copyright © 2020 Satheeshwaran Jeevanandan - (Digital). All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    private var lManager = LocationManger()
    private var currentLocation:CLLocation?
    private var placeName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setWeatherHomeNavStyle()
        self.navigationController?.navigationBar.isHidden = true
        if let userSelection = WeatherManager.sharedInstance().retriveWeatherLocation(){
            proceedToWeatherHome(selection: userSelection)
        }
    }
    
    @IBAction func autoDetectTapped(_ sender: Any) {
        lManager.initializeWithHandler { [weak self] (location) in
            self?.currentLocation = location
            print("location recieved--> latitude \(location.coordinate.latitude) longitude \(location.coordinate.longitude)")
            self?.saveUserSelection(placeName: nil, location: location.coordinate)
            self?.performSegue(withIdentifier: "WeatherHome", sender: self)
        }
        lManager.getCurrentLocation()
    }
    
    @IBAction func enterManualTapped(_ sender: Any) {
        let alertController = UIAlertController(title:"Alert" , message: "Enter the city name with country, example: Dubai, UAE", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Chennai, India"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let field = alertController.textFields![0] as UITextField
            self.placeName = field.text
            self.saveUserSelection(placeName: self.placeName ?? "", location: nil)
            self.performSegue(withIdentifier: "WeatherHome", sender: self)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil )
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func proceedToWeatherHome(selection: UserSelection)  {
        if let placeName = selection.placeName {
            self.placeName = placeName
        }else if let lat = selection.latitude, let lon = selection.longitude{
            self.currentLocation = CLLocation.init(latitude:lat , longitude: lon)
        }else{
            return;
        }
        self.performSegue(withIdentifier: "AutoSave", sender: self)
    }
    
    func saveUserSelection(placeName: String?, location: CLLocationCoordinate2D?)  {
        let selection = UserSelection(placeName: placeName, latitude: location?.latitude, longitude: location?.longitude)
        WeatherManager.sharedInstance().saveWeathreLocation(userchoise: selection)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WeatherHome" || segue.identifier == "AutoSave" {
            if let destinationVC = segue.destination as? WeatherViewController {
                destinationVC.location = currentLocation?.coordinate
                destinationVC.placeName = placeName?.replacingOccurrences(of: " ", with: "")
            }
        }
    }
}

