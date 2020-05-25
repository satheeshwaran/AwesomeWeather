//
//  WeatherViewController.swift
//  AwesomeWeather
//
//  Created by Satheeshwaran Jeevanandan - (Digital) on 21/05/20.
//  Copyright © 2020 Satheeshwaran Jeevanandan - (Digital). All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    var location:CLLocationCoordinate2D?
    var placeName:String?
    var weatherData:Forecast?
    private var forecastModel: ForecastViewModel?
    private var forecastDataSource: GenericTableViewDataModel<WeatherTableViewCell,Weather>?
    @IBOutlet weak var weatherTableView: UITableView!
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setWeatherHomeNavStyle()
        navigationItem.hidesBackButton = true
        refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        weatherTableView.addSubview(refreshControl)
        refreshControl.tintColor = .white
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        initiliazeUI()
    }
    
    private func initiliazeUI() {
        forecastModel = ForecastViewModel(interface: self)
        weatherTableView.tableFooterView = UIView()
        refreshData()
    }
    
    @objc private func refreshData(){
        if let place = placeName{
            forecastModel?.getWeatherForCity(city: place)
        }else if let loc = location{
            forecastModel?.getWeatherForCoordinates(location: loc)
        }
    }
    
    private func updateUI() {
        if let forecastItems = forecastModel?.forecast?.forecastList, let city = forecastModel?.forecast?.cityName{
            forecastDataSource = GenericTableViewDataModel(cellIdentifier: WeatherTableViewCell.reuseIdentifier, items: forecastItems, delegate: { (cell, model) in
                cell.time?.text=model.time
                cell.date?.text=model.date
                if let url = model.getWeatherIcon(){
                    cell.icon.setImage(from: url)
                }
                cell.temp?.text=model.temperature
                cell.overview?.text=model.description
                cell.precipitation?.text=model.humidity
            })
            DispatchQueue.main.async {
                self.weatherTableView.dataSource = self.forecastDataSource
                self.weatherTableView.reloadData()
                self.navigationController?.navigationBar.topItem?.title = city
                if(self.refreshControl.isRefreshing){
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }
}

extension WeatherViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension WeatherViewController: ViewModelInterface{
    func didUpdate() {
        updateUI()
    }
    
    func didError(error: String) {
        showAlert(message: error)
    }
    
    func onNetworkError() {
        showAlert(message: "Oops something went wrong")
    }
    
}
