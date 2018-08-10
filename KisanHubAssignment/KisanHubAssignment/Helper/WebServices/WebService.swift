//
//  WebService.swift
//  KisanHubAssignment
//
//  Created by Ashwinkumar Mangrulkar on 10/08/18.
//  Copyright © 2018 Ashwinkumar Mangrulkar. All rights reserved.
//

import Foundation
import Alamofire
import Reachability

class WebService {
    
    static let sharedInstance = WebService()

    /// Function to check Imternet Connection available or not
    ///
    /// - Returns: return bool value
    func isInternetAvailable()->Bool
    {
        //declare this property where it won't go out of scope relative to your listener
        let reachability = Reachability()!
        
        if reachability.connection != .none {
            return true
        } else {
            return false
        }
    }
    
    /// Web Servce for getting map data
    ///
    ///   - withCompletionHandler: Response
    func webServiceGetMapData(_ CompletionHandler:@escaping (_ success:Bool, _ responseDictionary:AnyObject?, _ error:NSError?)->Void)
    {
        //--Checking internet
        if isInternetAvailable()==false
        {
            CompletionHandler(false, nil, nil)
            return
        }
        
        Alamofire.request("https://s3.eu-west-2.amazonaws.com/interview-question-data/farm/farms.json").responseJSON { (response) in
            if let JSON = response.result.value {
                CompletionHandler(true, JSON as AnyObject?,response.result.error as NSError?)
            }else
            {
                CompletionHandler(false, nil,response.result.error as NSError?)
            }
        }
    }
    
}
