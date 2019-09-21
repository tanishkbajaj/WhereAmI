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
    
    @IBOutlet weak var shareButton: UIButton?
    
    @IBOutlet weak var pinButton: UIButton?
    
    @IBOutlet weak var historyButton: UIButton?
    let locationManager = CLLocationManager()
    var lat = 0.0
    var long = 0.0
    var sendingName: [String] = []
    var sendingLat: [Double] = []
    var sendingLong: [Double] = []
    
    
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
            activityItems: ["Here is my current address: \(AddressLabel.text!)  Coordinates are:( \(lat), \(long))"],
            applicationActivities: nil
        )
       // activity.popoverPresentationController? = sender
        
        // 3
        present(activity, animated: true, completion: nil)
    }
    
    
    @IBAction func showOnGoogleMapsButton(_ sender: Any) {
        
        if !sendingName.isEmpty{
        let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long)))
        source.name = "Source"
        
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long)))
        destination.name = self.sendingName.reversed()[0]
        
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
                self.sendingName.append(name)
                self.sendingLat.append(self.lat)
                self.sendingLong.append(self.long)
                print(self.sendingLat,self.sendingLong,"dekh")
                

            }
            
            
            
            let alert = UIAlertController(title: "Pinned It!", message: "You have saved the current address", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            
            self.present(alert, animated: true)
        }))
        
        self.present(alert, animated: true)
        
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
       // mapView.addAnnotation(annotation)
        print("this is annotation", annotation.coordinate)
    }
    
    
    @IBAction func historyButtonAction(_ sender: Any) {
        
//        let tableviewObject = NewTableViewController()
//        tableviewObject.storedAddressArray.append(addressStreet)
//         self.present(tableviewObject, animated: true, completion: nil)
//        performSegue(withIdentifier: "ViewtoCell", sender: self)
    }
    
    let blogSegueIdentifier = "ViewtoCell"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {


       // print(" title just after fetch\(savedDataTitleFromCore)")


        if  segue.identifier == blogSegueIdentifier,
            let destination = segue.destination as? NewTableViewController {
            destination.storedAddressArray = sendingName
            destination.storedLatArray = sendingLat
            destination.storedLongArray = sendingLong


        }




    }
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
self.mapView.showsUserLocation = true
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
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
        
        shareButton?.layer.cornerRadius = 8.0
        shareButton?.layer.borderWidth = 1.0
        shareButton?.layer.borderColor = UIColor.orange.cgColor
        
        pinButton?.layer.cornerRadius = 8.0
        pinButton?.layer.borderWidth = 1.0
        pinButton?.layer.borderColor = UIColor.orange.cgColor
        
        historyButton?.layer.cornerRadius = 8.0
        historyButton?.layer.borderWidth = 1.0
        historyButton?.layer.borderColor = UIColor.orange.cgColor
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

            let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        self.lat = locValue.latitude
        self.long = locValue.longitude
            print(locValue.latitude,"hi")
        latLongLabelMap.text = "\(locValue.latitude), \(locValue.longitude)"
            self.mapView.mapType = MKMapType.standard

            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: locValue, span: span)
            self.mapView.setRegion(region, animated: true)
        
        getAddressFromLatLon(pdblLatitude: "\(lat)", withLongitude: "\(long)")

    }
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
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
