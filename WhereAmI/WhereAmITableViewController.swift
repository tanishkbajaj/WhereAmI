//
//  WhereAmITableViewController.swift
//  WhereAmI
//
//  Created by IMCS2 on 9/15/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class WhereAmITableViewController: UITableView,UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
////        tableView.delegate = self
////        tableView.dataSource = self
////        self.locationManager.requestAlwaysAuthorization()
////
////        // For use in foreground
////        self.locationManager.requestWhenInUseAuthorization()
////
////        if CLLocationManager.locationServicesEnabled() {
////            locationManager.delegate = self
////            locationManager.desiredAccuracy = kCLLocationAccuracyBest
////            locationManager.startUpdatingLocation()
////        }
////
////        mapView.delegate = self
////       mapView.mapType = .standard
////        mapView.isZoomEnabled = true
////        mapView.isScrollEnabled = true
////
////        if let coor = mapView.userLocation.location?.coordinate{
////            mapView.setCenter(coor, animated: true)
////        }
//    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print("im here")
//        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//        
//        mapView.mapType = MKMapType.standard
//        
//        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        let region = MKCoordinateRegion(center: locValue, span: span)
//        mapView.setRegion(region, animated: true)
//        
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = locValue
//        annotation.title = "Javed Multani"
//        annotation.subtitle = "current location"
//        mapView.addAnnotation(annotation)
//        
//        //centerMap(locValue)
//    }
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 3
//    }

    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // var cell = tableView.dequeueReusableCell(withIdentifier: " ", for: indexPath)

        if indexPath.row == 0 {
            var cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! LabelCell


//            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//                print("im here")
//                let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//
//                cell.mapViewOutlet.mapType = MKMapType.standard
//
//                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//                let region = MKCoordinateRegion(center: locValue, span: span)
//                cell.mapViewOutlet.setRegion(region, animated: true)
//
//                let annotation = MKPointAnnotation()
//                annotation.coordinate = locValue
//                annotation.title = "Javed Multani"
//                annotation.subtitle = "current location"
//                cell.mapViewOutlet.addAnnotation(annotation)
//
//                //centerMap(locValue)
//            }


            return cell1

        }
        else  {
            var cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! ButtonCell
            return cell2
        }




    }
//
//
//
//
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//    */
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300
//    }
//
//    /*
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
//    */
//
//    /*
//    // Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//
//    }
//    */
//
//    /*
//    // Override to support conditional rearranging of the table view.
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the item to be re-orderable.
//        return true
//    }
//    */
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */

}
