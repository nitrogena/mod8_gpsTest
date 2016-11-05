//
//  ElPin.swift
//  GPSTest
//
//  Created by Invitado on 22/10/16.
//  Copyright © 2016 Invitado. All rights reserved.
//

import Foundation
import MapKit

//CON PROTOCOLO MKAnnotation
class ElPin:NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
}