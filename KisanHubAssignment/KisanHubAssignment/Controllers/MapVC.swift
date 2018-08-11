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
    
    /// Button select option object
    @IBOutlet weak var btnSelectOption: UIButton!
    
    /// Create map model object
    var mapModel = MapModel()
    
    var jsonGlobalObject: [AnyObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        btnSelectOption.isEnabled = false
        
        mapView.isMyLocationEnabled = true
        LocationManager.sharedInstance.delegate = self
        
        webServiceGetMapData()
    }
    
    @IBAction func selectOptionAction(_ sender: Any) {
        showActionSheet()
    }
    
    
    /// Show action sheet for iPhone
    func showActionSheet()
    {
        let actionSheet = UIAlertController(title: "Choose Option", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        actionSheet.popoverPresentationController?.sourceView = self.view
        
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Geometry Marker", comment: ""), style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.drawGeometryMarker(json: self.jsonGlobalObject!)
        }))
        
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Polygon", comment: ""), style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.drawPolygon(json: self.jsonGlobalObject!)
        }))
        
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
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
            
            self.btnSelectOption.isEnabled = true
            
            if let jsonArray = json as? [AnyObject] {
                self.jsonGlobalObject = jsonArray
                self.drawGeometryMarker(json: self.jsonGlobalObject!)
                //self.drawPolygon(json: jsonArray)
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
                        
                        self.mapView.camera = GMSCameraPosition.camera(withLatitude: farms.value(forKeyPath: "properties.farm_latitude") as! Double, longitude: farms.value(forKeyPath: "properties.farm_longitude") as! Double, zoom: 7.8)
                        
                        DispatchQueue.main.async
                            {
                                //Add marker
                                let markerPosition = CLLocationCoordinate2DMake(farms.value(forKeyPath: "properties.farm_latitude") as! Double, farms.value(forKeyPath: "properties.farm_longitude") as! Double)
                                let marker = GMSMarker(position: markerPosition)
                                marker.map = self.mapView
                                marker.title = farms.value(forKeyPath: "properties.farm_name") as? String
                                bounds = bounds.includingCoordinate(marker.position)
                                
                                let update = GMSCameraUpdate.fit(bounds, withPadding: 100)
                                self.mapView.animate(with: update)

                        }
                        
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
                                    
                                    let polygon = GMSPolygon()
                                    let rect = GMSMutablePath()
                                    
                                    if let polygons = points as? [AnyObject] {
                                        for index in 0..<points.count {
                                            if let values = polygons[index] as? [AnyObject] {
                                                print(values[0], values[1])
                                                
                                                let polygonLat = values[0] as! Double
                                                let polygonLong = values[1] as! Double
                                                
                                                
                                                rect.add(CLLocationCoordinate2DMake(polygonLat, polygonLong))
                                                
                                                self.mapView.camera = GMSCameraPosition.camera(withLatitude: polygonLat, longitude: polygonLong, zoom: 10)
                             
                                            }
                                        }
                                    }
                                    
                                    
                                    polygon.path = rect
                                    polygon.fillColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                                    polygon.strokeColor = UIColor.black
                                    polygon.strokeWidth = 3
                                    polygon.map = mapView
                                    
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
