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
import GoogleMobileAds

class ViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate, GADBannerViewDelegate {
    
    
    let locationManager = CLLocationManager()
    
    var location : Location = Location()
    
    var sendingLocation = [Location]()
    
    
    @IBOutlet weak var historyButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var pinButton: UIButton!
    
    
    @IBOutlet weak var latLongLabelMap: UILabel!
    
    @IBOutlet weak var AddressLabel: UILabel!
    var addressStreet: String = " "
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    @IBOutlet weak var BannerView2: GADBannerView!

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
        
        if  !CoreDatabase.fetchLocations().isEmpty {
            let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)))
            source.name = "My Location"
            
            let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: CoreDatabase.fetchLastLocation().latitude, longitude: CoreDatabase.fetchLastLocation().longitude)))
            
            destination.name = CoreDatabase.fetchLastLocation().address
            
            MKMapItem.openMaps(with: [source, destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
        }else {
            
            let alert = UIAlertController(title: "Last Pinned Address", message: "You are yet to pin any address, this button takes you to last Pinned address", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
    
    
    @IBAction func pinButtonAction(_ sender: Any) {
        let linkedViewcontroller = LinkAccountTableViewController()
        
        let alert = UIAlertController(title: "Pin Name", message: "Set name so you can easily identify later!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            //textField.placeholder = self.addressStreet
            textField.text = self.addressStreet
        })
        
       print("seeee thisssss", linkedViewcontroller.switchViewBool )
        if linkedViewcontroller.switchViewBool {
            let currentLocation = Location(AddressLabel.text!, self.location.latitude, self.location.longitude, Date())
            self.sendingLocation.append(currentLocation)
            CoreDatabase.saveLocation(currentLocation)
            
            let alert = UIAlertController(title: "Pinned It!", message: "You have saved the current address", preferredStyle: .alert)
            
            enableAndDisableHistoryButton()
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
        }
        else{
            alert.addAction(UIAlertAction(title: "Pin It!", style: .default, handler: { action in
                
                if let address = alert.textFields?.first?.text {
                    let currentLocation = Location(address, self.location.latitude, self.location.longitude, Date())
                    self.sendingLocation.append(currentLocation)
                    CoreDatabase.saveLocation(currentLocation)
                }
                
                
                let alert = UIAlertController(title: "Pinned It!", message: "You have saved the current address", preferredStyle: .alert)
                self.enableAndDisableHistoryButton()
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                
                self.present(alert, animated: true)
            }))
        }
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
            //   destination.storedLocation = sendingLocation
            destination.getCurrLocation = location
            
            
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
        
        shareButton?.layer.cornerRadius = 8.0
        shareButton?.layer.borderWidth = 1.0
        shareButton?.layer.borderColor = UIColor.orange.cgColor
        
        pinButton?.layer.cornerRadius = 8.0
        pinButton?.layer.borderWidth = 1.0
        pinButton?.layer.borderColor = UIColor.orange.cgColor
        
        historyButton?.layer.cornerRadius = 8.0
        historyButton?.layer.borderWidth = 1.0
        historyButton?.layer.borderColor = UIColor.orange.cgColor
        
        //adding Ad
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        BannerView2.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        BannerView2.rootViewController = self
        BannerView2.load(GADRequest())
        BannerView2.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        enableAndDisableHistoryButton()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        self.location.latitude = locValue.latitude
        self.location.longitude = locValue.longitude
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
    
    func enableAndDisableHistoryButton () {
        
        if CoreDatabase.fetchLocations().isEmpty {self.historyButton.isEnabled = false} else {self.historyButton.isEnabled = true}
    }
    
}
