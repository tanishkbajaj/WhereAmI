//
//  ViewController.swift
//  WhereAmI
//
//  Created by IMCS2 on 9/17/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {
    
    
    let locationManager = CLLocationManager()
 
    var location : Location = Location()
    
    var sendingLocation = [Location]()
    
    
    @IBOutlet weak var latLongLabelMap: UILabel!
    
    @IBOutlet weak var AddressLabel: UILabel!
    var addressStreet: String = " "
    
    @IBAction func SettingBarButton(_ sender: Any) {
        
    }
    
    
    @IBAction func RateOnAppStoreButton(_ sender: Any) {
        
        
        // App Store URL.
        let appStoreLink = "https://itunes.apple.com/us/app/apple-store/id1190643586"
        
        
        if let url = URL(string: appStoreLink), UIApplication.shared.canOpenURL(url) {
            
            UIApplication.shared.open(url, options: [:], completionHandler: {(success: Bool) in
                if success {
                    print("Launching \(url) was successful")
                }})
        }
        
    }
    
    
    @IBAction func shareButtonAction(_ sender: Any) {
        
        let activity = UIActivityViewController(
            activityItems: ["Here is my current address: \(AddressLabel.text!)  Coordinates are:( \(location.latitude), \(location.longitude))"],
            applicationActivities: nil
        )
        present(activity, animated: true, completion: nil)
    }
    
    
    @IBAction func showOnGoogleMapsButton(_ sender: Any) {
        
        if !sendingLocation.isEmpty{
            let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)))
            source.name = "Source"
            
            let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)))
            destination.name = self.sendingLocation.reversed()[0].name
            
            MKMapItem.openMaps(with: [source, destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
        }else {
            
            let alert = UIAlertController(title: "Last Pinned Address", message: "You are yet to pin any address, this button takes you to last Pinned address", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
    
    
    @IBAction func pinButtonAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Pin Name", message: "Set name so you can easily identify later!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            //textField.placeholder = self.addressStreet
            textField.text = self.addressStreet
        })
        
        alert.addAction(UIAlertAction(title: "Pin It!", style: .default, handler: { action in
            
            if let name = alert.textFields?.first?.text {
                print("Your name: \(name)")
                self.sendingLocation.append(Location(name, self.location.latitude, self.location.longitude, Date()))
                
            }
            
            
            let alert = UIAlertController(title: "Pinned It!", message: "You have saved the current address", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            
            self.present(alert, animated: true)
        }))
        
        self.present(alert, animated: true)
        
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        // mapView.addAnnotation(annotation)
        print("this is annotation", annotation.coordinate)
    }
    
    
    @IBAction func historyButtonAction(_ sender: Any) {
        
    }
    
    let blogSegueIdentifier = "ViewtoCell"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  segue.identifier == blogSegueIdentifier,
            let destination = segue.destination as? NewTableViewController {
            destination.storedLocation = sendingLocation
            
        }
        
        
        
        
    }
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.showsUserLocation = true
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        self.location.latitude = locValue.latitude
        self.location.longitude = locValue.longitude
        print(locValue.latitude,"hi")
        latLongLabelMap.text = "\(locValue.latitude), \(locValue.longitude)"
        self.mapView.mapType = MKMapType.standard
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: locValue, span: span)
        self.mapView.setRegion(region, animated: true)
        
        getAddressFromLatLon(pdblLatitude: "\(location.latitude)", withLongitude: "\(location.longitude)")
        
    }
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = Double("\(pdblLatitude)")!
        center.longitude = Double("\(pdblLongitude)")!
        
        let loc: CLLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks as? [CLPlacemark]
                
                if pm?.count ?? 0 > 0 {
                    let pm = placemarks![0]
                    self.addressStreet = pm.name!
                    print(pm.administrativeArea)
                    //                    print(pm.locality)
                    //                    print(pm.subLocality)
                    //                    print(pm.thoroughfare)
                    //                    print(pm.postalCode)
                    //             print(pm.subThoroughfare)
                    var addressString : String = ""
                    //                    if pm.subThoroughfare != nil {
                    //                        addressString = addressString + pm.subThoroughfare! + ", "
                    //                    }
                    //
                    //                    if pm.thoroughfare != nil {
                    //                        addressString = addressString + pm.thoroughfare! + ", "
                    //                    }
                    
                    if pm.name != nil {
                        addressString = addressString + pm.name! + ", "
                    }
                    
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    //                    if pm. = nil {
                    //                        addressString = addressString + pm.
                    //                    }
                    
                    if pm.administrativeArea != nil {
                        addressString = addressString + pm.administrativeArea! + ", "
                    }
                    
                    //                    if pm.subLocality != nil {
                    //                        addressString = addressString + pm.subLocality! + ", "
                    //                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + ", "
                    }
                    
                    if pm.country != nil {
                        addressString = addressString + pm.country! + " "
                    }
                    
                    
                    self.AddressLabel.text = addressString
                    print(addressString)
                }
        })
        
    }
    
    
}
