//
//  GenericTableViewCellModel.swift
//  AwesomeWeather
//
//  Created by Satheeshwaran Jeevanandan - (Digital) on 21/05/20.
//  Copyright © 2020 Satheeshwaran Jeevanandan - (Digital). All rights reserved.
//

import Foundation
import UIKit

/// Generic UITableView data model class to handle simple tableview logic from an array of models
class GenericTableViewDataModel<GenericTableCell: UITableViewCell, GenericViewModel>: NSObject, UITableViewDataSource{
    
    /// Reuse identifier for the cells.
    private var cellReuseIdentifier: String!
    
    /// Data source items.
    private var dataItems: [GenericViewModel]!
    
    /// Cell configuration completion to update cell details.
    var cellConfigurationHandler :(GenericTableCell,GenericViewModel) -> ()
    
    /// Initiliazer for GenericTableViewDataModel
    ///
    /// - Parameters:
    ///   - cellIdentifier: cell identifier.
    ///   - items: data source array.
    ///   - delegate: delegate completion handler to customize cell.
    init(cellIdentifier :String, items :[GenericViewModel], delegate: @escaping (GenericTableCell,GenericViewModel) -> ()) {
        cellReuseIdentifier = cellIdentifier
        dataItems = items
        cellConfigurationHandler = delegate
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! GenericTableCell
        let modelItem = dataItems[indexPath.row]
        cellConfigurationHandler(cell, modelItem)
        return cell
    }
    
}
