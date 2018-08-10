//
//  LocationManager.swift
//  KisanHubAssignment
//
//  Created by Ashwinkumar Mangrulkar on 10/08/18.
//  Copyright © 2018 Ashwinkumar Mangrulkar. All rights reserved.
//

import Foundation
import CoreLocation

/// Location protocol
protocol LocationProtocol {
    func udpatedLocation(location: CLLocation)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    /// Singleton instance of LocationManager
    static var sharedInstance = LocationManager()
    
    /// Create location manager object
    var locationManager = CLLocationManager()
    
    /// delegate object to call protocol method
    var delegate: LocationProtocol?
    
    private(set) var latitude: Double?
    private(set) var longitude: Double?
    
    /// Initialization
    override init() {
        super.init()
        
        //Location Manager code to fetch current location
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
    
    //MARK:- Location Manager delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        delegate?.udpatedLocation(location: location!)
        
        latitude = location?.coordinate.latitude
        longitude = location?.coordinate.longitude
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
    }
    
    /// Get user current location
    ///
    /// - Returns: CLLocation object
    func getCurrentLocation() -> CLLocation {
        return CLLocation(latitude: latitude!, longitude: longitude!)
    }

}
