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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webServiceGetClimateData()
    }
    
    func webServiceGetClimateData() {
        
        SVProgressHUD.show()
        
        WebService.sharedInstance.webServiceGetClimateData { (success, response, error) in
            
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
            var tempArray: [[String]] = []
            let formattedArray = self.formatFile(data: json) as Array
            
            for index in 7..<formattedArray.count-1 {
                tempArray.append(formattedArray[index])
            }
            
            for index in 0..<tempArray.count {
                if let data = tempArray[index] as? [String] {
                    let str = data[0].components(separatedBy: " ")
                   
                    print(str)
                    
                }
            }
            
            
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

// MARK: - Extension to remove spaces
extension String {
    mutating func removeSpaces() {
        self = self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
