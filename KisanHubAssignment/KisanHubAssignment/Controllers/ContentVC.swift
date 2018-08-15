//
//  ContentVC.swift
//  KisanHubAssignment
//
//  Created by Ashwinkumar Mangrulkar on 10/08/18.
//  Copyright © 2018 Ashwinkumar Mangrulkar. All rights reserved.
//

import UIKit
import SVProgressHUD

class ContentVC: UIViewController {
    
    /// Tableview object
    @IBOutlet weak var tableView: UITableView!
    
    /// Tableview cell indentifier
    let cellIdentifier: [String] = ["map", "article", "region"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /// Remove unwanted seprator
        tableView.tableFooterView = UIView()
        
        let documentsURL = try! FileManager().url(for: .documentDirectory,
                                                  in: .userDomainMask,
                                                  appropriateFor: nil,
                                                  create: true)
        
        /// Generate dynamic url for fetching data
        for outerIndex in 0..<country.count {
            for innerIndex in 0..<climate_parameters.count {
                
                let fileURL = documentsURL.appendingPathComponent("\(country[outerIndex])\(climate_parameters[innerIndex]).txt")
                
                if !FileManager.default.fileExists(atPath: fileURL.path) {
                    webServiceGetClimateData(fileName: "\(country[outerIndex])\(climate_parameters[innerIndex])", params: climate_parameters[innerIndex], country: country[outerIndex])
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        /// Hide back button text for next controller
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    /// Web service call to get climate data
    func webServiceGetClimateData(fileName: String, params: String, country: String) {
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.clear)
        
        WebService.sharedInstance.webServiceGetClimateData(fileName: fileName, param: params, country: country) { (success, response, error) in
            
            SVProgressHUD.dismiss()
            
            if error != nil {
                CustomAlertView.showNegativeAlert(NSLocalizedString("ALERT_SERVER_ERROR", comment: ""))
                return
            }
            
            guard let _ = response, response != nil, success else {
                CustomAlertView.showNegativeAlert(NSLocalizedString("ALERT_RESPONSE_ERROR", comment: ""))
                return
            }
            //            print("Response json: \(json)")
        }
    }
    
}

extension ContentVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier[indexPath.row], for: indexPath)
        return cell
    }
}
