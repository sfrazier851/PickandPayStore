//
//  TrackOrderModel.swift
//  PickandPayStore
//
//  Created by Ives Murillo on 4/5/22.
//

import Foundation
import CoreLocation

final class TrackOrderModel: ObservableObject{
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnable() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
        } else{
            print("show an alert showing this is off")
        }
    }
}
