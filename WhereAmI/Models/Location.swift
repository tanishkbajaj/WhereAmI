//
//  Location.swift
//  WhereAmI
//
//  Created by IMCS on 9/20/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import Foundation
struct Location {
    var name : String = ""
    var address : String = ""
    var longitude : Double = 0.0
    var latitude : Double = 0.0
    var date : Date = Date()
    init () {
        
    }
    init( _ address : String, _ latitude : Double,_ longitude : Double, _ date : Date, _ name : String  = "") {
        self.name = name
        self.address = address
        self.longitude = longitude
        self.latitude = latitude
        self.date = Date()
    }
}
