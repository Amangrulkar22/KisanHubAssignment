//
//  MapVC.swift
//  KisanHubAssignment
//
//  Created by Ashwinkumar Mangrulkar on 10/08/18.
//  Copyright © 2018 Ashwinkumar Mangrulkar. All rights reserved.
//

import UIKit
import GoogleMaps
import SVProgressHUD

class MapVC: UIViewController {
    
    /// Mapview object
    @IBOutlet weak var mapView: GMSMapView!
    
    /// Create map model object
    var mapModel = MapModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        mapView.isMyLocationEnabled = true
        LocationManager.sharedInstance.delegate = self
        
        webServiceGetMapData()
    }
    
    /// Webservice call to get data and display on map
    func webServiceGetMapData() {
        
        SVProgressHUD.show()
        
        WebService.sharedInstance.webServiceGetMapData { (success, response, error) in
            
            SVProgressHUD.dismiss()
            
            if error != nil {
                CustomAlertView.showNegativeAlert(NSLocalizedString("ALERT_SERVER_ERROR", comment: ""))
                return
            }
            
            guard let json = response, response != nil, success else {
                CustomAlertView.showNegativeAlert(NSLocalizedString("ALERT_RESPONSE_ERROR", comment: ""))
                return
            }
            
            //            print("Response json: \(json)")
            
            if let jsonArray = json as? [AnyObject] {
                self.drawGeometryMarker(json: jsonArray)
                self.drawPolygon(json: jsonArray)
            }
            
        }
    }
    
    /// Function to load camera according to response
    ///
    /// - Parameter json: json data
    func drawGeometryMarker(json: [AnyObject]) {
        
        if json.count > 0 {
            var bounds = GMSCoordinateBounds()
            
            if let farmsDict = json[0] as? NSDictionary {
                if let farmsArray = farmsDict.value(forKey: "farms") as? [AnyObject] {
                    for farms in farmsArray {
                        
                        self.mapView.camera = GMSCameraPosition.camera(withLatitude: farms.value(forKeyPath: "properties.farm_latitude") as! Double, longitude: farms.value(forKeyPath: "properties.farm_longitude") as! Double, zoom: 7.5)
                        
                        DispatchQueue.main.async
                            {
                                //Add marker
                                let markerPosition = CLLocationCoordinate2DMake(farms.value(forKeyPath: "properties.farm_latitude") as! Double, farms.value(forKeyPath: "properties.farm_longitude") as! Double)
                                let marker = GMSMarker(position: markerPosition)
                                marker.map = self.mapView
                                marker.title = farms.value(forKeyPath: "properties.farm_name") as? String
                                bounds = bounds.includingCoordinate(marker.position)
                        }
                        
                        let update = GMSCameraUpdate.fit(bounds, withPadding: 100)
                        mapView.animate(with: update)
                    }
                }
            }
        }
    }
    
    /// Function to draw polygon
    ///
    /// - Parameter json: json object
    func drawPolygon(json: [AnyObject]) {
        
        if json.count > 0 {
            
            if let fieldsDict = json[0] as? NSDictionary {
                if let fieldsArray = fieldsDict.value(forKey: "fields") as? [AnyObject] {
                    for fieldObject in fieldsArray {
                        if let geometry = fieldObject.value(forKey: "geometry") as? NSDictionary {
                            if let coordinates = geometry.value(forKey: "coordinates") as? [AnyObject] {
                                if let points = coordinates[0] as? [AnyObject]{
                                    if let polygon = points[0] as? [AnyObject] {
                                        for _ in polygon {
                                            print(polygon[0], polygon[1])
                                            
                                            let polygonLat = polygon[0] as! Double
                                            let polygonLong = polygon[1] as! Double

                                            let polygon = GMSPolygon()
                                            let rect = GMSMutablePath()
                                            rect.add(CLLocationCoordinate2DMake(polygonLat, polygonLong))
                                            
                                            polygon.path = rect
                                            polygon.fillColor = UIColor(red: 0.25, green: 0, blue: 0, alpha: 0.2)
                                            polygon.strokeColor = UIColor.black
                                            polygon.strokeWidth = 5
                                            polygon.map = mapView
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension MapVC: LocationProtocol {
    
    /// Delegate method of locaiton manager
    ///
    /// - Parameter location: location object
    func udpatedLocation(location: CLLocation) {
        
        mapModel.sourceLatitude = location.coordinate.latitude
        mapModel.sourceLongitude = location.coordinate.longitude
        
        //        btnSource.setTitle("  \(mapModel.sourceLatitude!),\(mapModel.sourceLongitude!)", for: .normal)
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 13.0)
        
        self.mapView?.animate(to: camera)
        
    }
}
