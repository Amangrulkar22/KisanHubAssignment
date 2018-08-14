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
    
    /// WebServce call to get map data
    ///
    ///   - withCompletionHandler: Response
    func webServiceGetClimateData(fileName: String, param: String, country: String, _ CompletionHandler:@escaping (_ success:Bool, _ responseDictionary:String?, _ error:NSError?)->Void)
    {
        //--Checking internet
        if isInternetAvailable()==false
        {
            CompletionHandler(false, nil, nil)
            return
        }
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            // the name of the file here I kept is yourFileName with appended extension
            documentsURL.appendPathComponent("\(fileName).txt")
            return (documentsURL, [.removePreviousFile])
        }
        
        let url = String(format: Climate_Base_Url, param, country)
        
        print(url)
        
        Alamofire.download(url, to: destination).response { response in
            if response.destinationURL != nil {
                print(response.destinationURL!)
                
                let file = "\(fileName).txt" //this is the file. we will write to and read from it
                
                if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    
                    let fileURL = dir.appendingPathComponent(file)
                    
                    //reading
                    do {
                        let textData = try String(contentsOf: fileURL, encoding: .utf8)
                        CompletionHandler(true, textData, response.error as NSError?)
                    }
                    catch {/* error handling here */
                        CompletionHandler(false, nil, response.error as NSError?)
                    }
                }
            }
        }
    }
    
    /// WebServce call to get map data
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
    
    /// WebServce call to get article data
    ///
    ///   - withCompletionHandler: Response
    func webServiceGetArticles(_ CompletionHandler:@escaping (_ success:Bool, _ responseDictionary:AnyObject?, _ error:NSError?)->Void)
    {
        //--Checking internet
        if isInternetAvailable()==false
        {
            CompletionHandler(false, nil, nil)
            return
        }
        
        Alamofire.request("https://s3.eu-west-2.amazonaws.com/interview-question-data/articles/articles.json").responseJSON { (response) in
            if let JSON = response.result.value {
                CompletionHandler(true, JSON as AnyObject?,response.result.error as NSError?)
            }else
            {
                CompletionHandler(false, nil,response.result.error as NSError?)
            }
        }
    }
    
}
