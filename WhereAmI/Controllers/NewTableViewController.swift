//
//  NewTableViewController.swift
//  WhereAmI
//
//  Created by IMCS2 on 9/18/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import UIKit
import MapKit
import GoogleMobileAds

class NewTableViewController: UITableViewController, GADInterstitialDelegate, UIAlertViewDelegate {
    
    var storedLocation  = [Location]()
    var getCurrLocation: Location = Location()
    var interstitial: GADInterstitial!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "HistoryItemsTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "HistoryItemsTableViewCell")
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        
        let request = GADRequest()
        interstitial.load(request)
        interstitial.delegate = self
        interstitial.present(fromRootViewController: self)
        
    }
//    override func viewWillAppear(_ animated: Bool) {
//
//        if interstitial.isReady {
//            interstitial.present(fromRootViewController: self)
//        } else {
//            print("Ad wasn't ready")
//        }
//
//    }
    
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
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
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: getCurrLocation.latitude , longitude: getCurrLocation.longitude)))
        source.name = "My Location"
        
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: storedLocation.reversed()[indexPath.row].latitude, longitude: storedLocation.reversed()[indexPath.row].longitude)))
        
        destination.name = storedLocation.reversed()[indexPath.row].address
        MKMapItem.openMaps(with: [source, destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
    
}
