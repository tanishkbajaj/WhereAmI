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
    
    var storedLocation  = [Location]()
    
    //    var storedAddressArray: [String] = []
    //    var storedLatArray: [Double] = []
    //    var storedLongArray: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("look", storedLocation)
        
        let nibName = UINib(nibName: "HistoryItemsTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "HistoryItemsTableViewCell")
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return storedLocation.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryItemsTableViewCell", for: indexPath) as! HistoryItemsTableViewCell
        
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        
        cell.LocationNameLabel.text = storedLocation.reversed()[indexPath.row].address
        
        cell.DateLabel.text = dateFormatter.string(from: storedLocation.reversed()[indexPath.row].date)
        
        cell.TimeLabel.text = timeFormatter.string(from: storedLocation.reversed()[indexPath.row].date)
        
        
        
        print(storedLocation.reversed()[indexPath.row].date)
        
        
        
        
        print(dateFormatter.string(from: storedLocation.reversed()[indexPath.row].date))
        print(timeFormatter.string(from: storedLocation.reversed()[indexPath.row].date))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: storedLocation.reversed()[indexPath.row].longitude, longitude: storedLocation.reversed()[indexPath.row].latitude)))
        source.name = "Source"
        
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: storedLocation.reversed()[indexPath.row].longitude, longitude: storedLocation.reversed()[indexPath.row].latitude)))
        
        destination.name = storedLocation.reversed()[indexPath.row].address
        MKMapItem.openMaps(with: [source, destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
