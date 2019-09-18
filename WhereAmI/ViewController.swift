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
    var lat = 0.0
    var long = 0.0
    
    @IBOutlet weak var latLongLabelMap: UILabel!
    
    @IBOutlet weak var AddressLabel: UILabel!
    
    @IBAction func SettingBarButton(_ sender: Any) {
        
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
        
//        let locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
//        self.lat = locValue.latitude
//        self.long = locValue.longitude
       // latLongLabelMap.text = "\(lat), \(long)"
        
        
        
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
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
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
