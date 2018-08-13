//
//  RegionClimateVC.swift
//  KisanHubAssignment
//
//  Created by Ashwinkumar Mangrulkar on 10/08/18.
//  Copyright © 2018 Ashwinkumar Mangrulkar. All rights reserved.
//

import UIKit
import SVProgressHUD

class RegionClimateVC: UIViewController {
    
    
    //Tmax/date/Scotland.txt - UK max temp
    
    /// Country array
    let country: [String] = ["UK", "England", "Wales", "Scotland"]

    /// Climate parameter array
    let climate_parameters: [String] = ["Tmax", "Tmin", "Tmean", "Sunshine", "Rainfall"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        for outerIndex in 0..<country.count {
            for innerIndex in 0..<climate_parameters.count {
                webServiceGetClimateData(fileName: "\(country[outerIndex])\(climate_parameters[innerIndex])", params: climate_parameters[innerIndex], country: country[outerIndex])
            }
        }
    }
    
    /// Web service call to get climate data
    func webServiceGetClimateData(fileName: String, params: String, country: String) {
        
        SVProgressHUD.show()
        
        WebService.sharedInstance.webServiceGetClimateData(fileName: fileName, param: params, country: country) { (success, response, error) in
            
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
//            var tempArray: [[String]] = []
//            let formattedArray = self.formatFile(data: json) as Array
//
//            for index in 7..<formattedArray.count-1 {
//                tempArray.append(formattedArray[index])
//            }
//
//            for index in 0..<tempArray.count {
//                if let data = tempArray[index] as? [String] {
//                    let str = data[0].condenseWhitespace()
//                    print(str)
//
//                }
//            }
        }
    }
    
    
    /// Function used to format txt file and make it readable
    ///
    /// - Parameter data: string value
    /// - Returns: formated array
    func formatFile(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ";")
            result.append(columns)
        }
        return result
    }
    
}
