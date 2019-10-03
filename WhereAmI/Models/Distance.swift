//
//  DistanceCalculator.swift
//  WhereAmI
//
//  Created by IMCS on 9/23/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import Foundation
import MapKit


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
        
        request.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: request)
        
        directions.calculate { (response, error) in
            if let response = response, let route = response.routes.first {
                completion(route.distance)
            } else {
                completion(-1.0)
            }
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
