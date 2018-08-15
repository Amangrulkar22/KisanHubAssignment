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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var btnParameter: UIButton!
    
    /// Empty array to store data
    var dataArray: [DTOClimate] = []
    
    var countryId: Int16 = 0
    var parameterId: Int16 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        /// Remove unwatned seprator
        tableView.tableFooterView = UIView()
        
        /// Insert record when database is empty
        if ClimateWrapper.sharedInstance.fetchRecords().count == 0 {
            DispatchQueue.main.async {
                self.insertDataIntoDatabase()
            }
        }else {
            /// Fetch first record from database
            fetchRecords(countryId: Country.UK.rawValue, paramId: CountryParams.MaxTemp.rawValue)
        }
        
        self.btnCountry.setTitle(country[0], for: .normal)
        self.btnParameter.setTitle(climate_parameters[0], for: .normal)
    }
    
    /// Insert record into database
    func insertDataIntoDatabase() {
        
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
        
        let documentsURL = try! FileManager().url(for: .documentDirectory,
                                                  in: .userDomainMask,
                                                  appropriateFor: nil,
                                                  create: true)
        
        /// Generate dynamic url for fetching data
        for outerIndex in 0..<country.count {
            for innerIndex in 0..<climate_parameters.count {
                
                let fileURL = documentsURL.appendingPathComponent("\(country[outerIndex])\(climate_parameters[innerIndex]).txt")
                
                if FileManager.default.fileExists(atPath: fileURL.path) {
                    
                    //reading
                    do {
                        let fileText = try String(contentsOf: fileURL, encoding: .utf8)
                        
                        var tempArray: [[String]] = []
                        let formattedArray = self.formatFile(data: fileText) as Array
                        
                        for index in 8..<formattedArray.count-2 {
                            tempArray.append(formattedArray[index])
                        }
                        
                        for index in 0..<tempArray.count {
                            if let data = tempArray[index] as? [String] {
                                let str = data[0].condenseWhitespace()
                                //                                print(str)
                                
                                let paramArray = str.components(separatedBy: " ")
                                
                                if paramArray.count > 0{
                                    
                                    var countryId: Int16 = 0
                                    var countryParamId: Int16 = 0
                                    
                                    /// Added dynamic id for country
                                    if outerIndex == Country.UK.rawValue {
                                        countryId = Country.UK.rawValue
                                    }else if outerIndex == Country.England.rawValue {
                                        countryId = Country.England.rawValue
                                    }else if outerIndex == Country.Wales.rawValue{
                                        countryId = Country.Wales.rawValue
                                    }else {
                                        countryId = Country.Scotland.rawValue
                                    }
                                    
                                    
                                    /// Added dynamic id for parameters
                                    if innerIndex == CountryParams.MaxTemp.rawValue {
                                        countryParamId = CountryParams.MaxTemp.rawValue
                                    }else if innerIndex == CountryParams.MinTemp.rawValue {
                                        countryParamId = CountryParams.MinTemp.rawValue
                                    }else if innerIndex == CountryParams.Sunshine.rawValue {
                                        countryParamId = CountryParams.Sunshine.rawValue
                                    }else {
                                        countryParamId = CountryParams.Rainfall.rawValue
                                    }
                                    
                                    let year = paramArray[0]
                                    let jan = paramArray[1]
                                    let feb = paramArray[2]
                                    let mar = paramArray[3]
                                    let apr = paramArray[4]
                                    let may = paramArray[5]
                                    let jun = paramArray[6]
                                    let jul = paramArray[7]
                                    let aug = paramArray[8]
                                    let sep = paramArray[9]
                                    let oct = paramArray[10]
                                    let nov = paramArray[11]
                                    let dec = paramArray[12]
                                    
                                    let model = DTOClimate(apr: apr, aug: aug, countryId: countryId, countryParamId: countryParamId, dec: dec, feb: feb, jan: jan, jul: jul, jun: jun, mar: mar, may: may, nov: nov, oct: oct, sep: sep, year: year)
                                    
                                    if ClimateWrapper.sharedInstance.insertRecord(model) {
                                        //                                        print("record inserted successfully")
                                    }else {
                                        //                                        print("Failed to insert record")
                                    }
                                }
                            }
                        }
                        
                    }
                    catch {/* error handling here */
                        
                    }
                }
            }
            
            /// Parse last record
            if outerIndex == country.count - 1 {
                
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                }
                
                /// Fetch first record from database
                fetchRecords(countryId: self.countryId, paramId: self.parameterId)
            }
        }
    }
    
    /// Fetch records from database
    ///
    /// - Parameters:
    ///   - countryId: country id
    ///   - paramId: param id
    func fetchRecords(countryId: Int16, paramId: Int16) {
        
        SVProgressHUD.show()
        
        if dataArray.count > 0 {
            dataArray.removeAll(keepingCapacity: true)
        }
        
        DispatchQueue.main.async {
            self.dataArray = ClimateWrapper.sharedInstance.fetchRecordsById(countryId: countryId, paramId: paramId)
            
            self.tableView.reloadData()
        }
        
        SVProgressHUD.dismiss()
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
    
    @IBAction func countryParameterButtonAction(_ sender: UIButton) {
        
        switch sender.tag {
        case ButtonAction.Country.rawValue:
            showActionSheet(identifier: true)
        case ButtonAction.Parameter.rawValue:
            showActionSheet(identifier: false)
            
        default:
            print("default")
        }
    }
    
    
    /// Show action sheet and getch records from database
    func showActionSheet(identifier: Bool)
    {
        let identifier = identifier
        var title1: String?
        var title2: String?
        var title3: String?
        var title4: String?
        
        if identifier {
            title1 = country[0]
            title2 = country[1]
            title3 = country[2]
            title4 = country[3]
        }else {
            title1 = climate_parameters[0]
            title2 = climate_parameters[1]
            title3 = climate_parameters[2]
            title4 = climate_parameters[3]
            
        }
        
        let actionSheet = UIAlertController(title: "Choose Option", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        actionSheet.popoverPresentationController?.sourceView = self.view
        
        actionSheet.addAction(UIAlertAction(title: title1, style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            if identifier {
                self.countryId = Country.UK.rawValue
                self.btnCountry.setTitle(title1, for: .normal)
            }else {
                self.parameterId = CountryParams.MaxTemp.rawValue
                self.btnParameter.setTitle(title1, for: .normal)
            }
            
            self.fetchRecords(countryId: self.countryId, paramId: self.parameterId)
        }))
        
        actionSheet.addAction(UIAlertAction(title: title2, style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            if identifier {
                self.countryId = Country.England.rawValue
                self.btnCountry.setTitle(title2, for: .normal)
            }else {
                self.parameterId = CountryParams.MinTemp.rawValue
                self.btnParameter.setTitle(title2, for: .normal)
            }
            
            self.fetchRecords(countryId: self.countryId, paramId: self.parameterId)
        }))
        
        actionSheet.addAction(UIAlertAction(title: title3, style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            if identifier {
                self.countryId = Country.Wales.rawValue
                self.btnCountry.setTitle(title3, for: .normal)
            }else {
                self.parameterId = CountryParams.Sunshine.rawValue
                self.btnParameter.setTitle(title3, for: .normal)
            }
            
            self.fetchRecords(countryId: self.countryId, paramId: self.parameterId)
        }))
        
        actionSheet.addAction(UIAlertAction(title: title4, style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            if identifier {
                self.countryId = Country.Scotland.rawValue
                self.btnCountry.setTitle(title4, for: .normal)
            }else {
                self.parameterId = CountryParams.Rainfall.rawValue
                self.btnParameter.setTitle(title4, for: .normal)
            }
            
            self.fetchRecords(countryId: self.countryId, paramId: self.parameterId)
        }))
        
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
}

// MARK: - UItableview delegates
extension RegionClimateVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ClimateTableViewCell else {
            return ClimateTableViewCell()
        }
        
        cell.displayData(dto: dataArray[indexPath.row])
        
        return cell
    }
}
