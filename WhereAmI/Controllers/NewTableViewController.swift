//
//  NewTableViewController.swift
//  WhereAmI
//
//  Created by IMCS2 on 9/18/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import UIKit
import MapKit

class NewTableViewController: UITableViewController {
    
    var storedLocations : [Location] = CoreDatabase.fetchLocations()
    var getCurrLocation: Location = Location()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "HistoryItemsTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "HistoryItemsTableViewCell")
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (storedLocations.count)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryItemsTableViewCell", for: indexPath) as! HistoryItemsTableViewCell
        
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        
        cell.LocationNameLabel.text = storedLocations.reversed()[indexPath.row].address
        
        cell.DateLabel.text = dateFormatter.string(from: storedLocations.reversed()[indexPath.row].date)
        
        cell.TimeLabel.text = timeFormatter.string(from: storedLocations.reversed()[indexPath.row].date)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: getCurrLocation.latitude , longitude: getCurrLocation.longitude)))
        source.name = "My Location"
        
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: storedLocations.reversed()[indexPath.row].latitude, longitude: storedLocations.reversed()[indexPath.row].longitude)))
        
        destination.name = storedLocations.reversed()[indexPath.row].address
        MKMapItem.openMaps(with: [source, destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle == .delete {
//        self.storedLocations.remove(at: indexPath.row)
//        tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            //self.storedLocations.remove(at: indexPath.row)
            
            
            
            var temporaryArray = Array(self.storedLocations.reversed())
            CoreDatabase.deleteLocation(temporaryArray[indexPath.row])
            temporaryArray.remove(at: indexPath.row)
      
            self.storedLocations = Array(temporaryArray.reversed())
           // tableView.reloadData()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            // tableView.reloadData()
           
        }
        
        let share = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            print("I want to edit: \(self.storedLocations.reversed()[indexPath.row])")
            
            let alert = UIAlertController(title: "Edit Address", message: "Change Address Name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addTextField(configurationHandler: { textField in
                textField.text = self.storedLocations.reversed()[indexPath.row].address
            })
            
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { action in
                
                if let address = alert.textFields?.first?.text {
                    var temporaryArray = Array(self.storedLocations.reversed())
                    temporaryArray[indexPath.row].address = address
                    CoreDatabase.updateLocation(temporaryArray[indexPath.row])
                    self.storedLocations = Array(temporaryArray.reversed())
                    tableView.reloadData()
                }
                
                
                let alert = UIAlertController(title: "Changed!", message: "You have edited the address", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                
                self.present(alert, animated: true)
            }))
            
            self.present(alert, animated: true)
            
        }
        
        share.backgroundColor = UIColor.lightGray
        
        return [delete, share]
        
    }
    
}
