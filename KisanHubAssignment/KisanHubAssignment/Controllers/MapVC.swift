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
            
            print("Response json: \(json)")
            
            self.loadCameraView(json: response!)
            
        }
    }
    
    func loadCameraView(json: AnyObject) {
        
        var bounds = GMSCoordinateBounds()

        let cameraPosition = GMSCameraPosition.camera(withLatitude: 19.017615, longitude: 72.856164, zoom: 5)
        let mapView = GMSMapView.map(withFrame: self.mapView.bounds, camera: cameraPosition)
        mapView.isMyLocationEnabled = true
        mapView.accessibilityElementsHidden = false
        
        //Add marker
        let sourcePosition = CLLocationCoordinate2DMake(19.017615, 72.856164)
        let markerSource = GMSMarker(position: sourcePosition)
        markerSource.map = mapView
        markerSource.title = "Ashwin"
        bounds = bounds.includingCoordinate(markerSource.position)
        
        let update = GMSCameraUpdate.fit(bounds, withPadding: 30)
        mapView.animate(with: update)
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
        
//        if mapModel.sourceLatitude != nil && mapModel.sourceLongitude != nil && mapModel.destinationLatitude != nil && mapModel.destinationLongitude != nil {
//            loadCameraView()
//        }
    }
}
