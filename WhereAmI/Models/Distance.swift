//
//  DistanceCalculator.swift
//  WhereAmI
//
//  Created by IMCS on 9/23/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import Foundation
import MapKit
import SwiftyJSON
import AFNetworking


class DistanceCalculator {
    
    static func routingDistance(_ userNotation: Location, _ destinationLocation: Location, completion: @escaping (CLLocationDistance) -> Void) {
        let request:MKDirections.Request = MKDirections.Request()
        
        // source and destination are the relevant MKMapItems
        let sourceS = CLLocationCoordinate2D(latitude: userNotation.latitude, longitude: userNotation.longitude)
        let destinationD = CLLocationCoordinate2D(latitude: destinationLocation.latitude, longitude: destinationLocation.longitude)
        let sourcePM = MKPlacemark(coordinate: sourceS)
        let destinationPM = MKPlacemark(coordinate: destinationD)
        request.source = MKMapItem(placemark: sourcePM)
        request.destination = MKMapItem(placemark: destinationPM)
        
        // Specify the transportation type
        request.transportType = MKDirectionsTransportType.automobile;
        
        // If you're open to getting more than one route,
        // requestsAlternateRoutes = true; else requestsAlternateRoutes = false;
        request.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: request)
        
        directions.calculate { (response, error) in
            if let response = response, let route = response.routes.first {
                print(route.distance)
                completion(route.distance)
            } else {
                completion(-1.0)
            }
        }
    }
    
    static func DistanceAndDuration(_ souLocation: Location, _ destLocation: Location) {
        let google_directions_places_key = "AIzaSyAJxl8F4I92B9PVnYko6GGbnQ2evW2Ce7g"
    var urlString = String(format:"https://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&alternatives=%@&mode=%@&key=%@",souLocation.latitude, souLocation.latitude, destLocation.latitude, destLocation.longitude, "true","driving", google_directions_places_key)
    
    urlString = urlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!
    
    
    let manager  = AFHTTPRequestOperationManager()
    
    manager.responseSerializer = AFJSONResponseSerializer(readingOptions: JSONSerialization.ReadingOptions.allowFragments) as AFJSONResponseSerializer
    
    manager.requestSerializer = AFJSONRequestSerializer() as AFJSONRequestSerializer
    
    manager.responseSerializer.acceptableContentTypes = NSSet(objects:"application/json", "text/html", "text/plain", "text/json", "text/javascript", "audio/wav") as Set<NSObject>
    
    
    
    manager.post(urlString, parameters: nil, success: { (operation, response) in
    
    
    if(response != nil)
    {
    let parsedData = JSON(response!)
    
    print("parsedData12554 : \(parsedData)")
    
    print("parsed : \(parsedData["status"])")
    
    if(parsedData["status"] == "OK")
    {
    
    let routes = parsedData["routes"][0]
    
    print("Routesss260 \(routes)")
    
    let legs = routes["legs"][0]
    
    let distance = legs["distance"]
    
    let duration = legs["duration"]
    
    let disValue = distance["value"].double!
    
    let durValue = duration["value"].double! / 3600.0
    
    print("disValue250 \(disValue)")
    
    print("durValue250 \(durValue)")
    
    
    
    
    
    
    }
    
    
    }
    
    
    
    }) { (operation, error) in
    
    
    print("eeee2566\(error)")
    
    
    }
    }
    
}



struct Distance {
    var distance : Double = 0.0
    var date : Date = Date()
    func toFormattedMile()->String {
        return String(format: "%.2f", self.distance/1609.34)
    }
    func toFormattedKilo()->String {
        return String(format: "%.2f", self.distance/1000.00)
    }
}
