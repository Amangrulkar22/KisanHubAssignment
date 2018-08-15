//
//  ClimateWrapper.swift
//  KisanHubAssignment
//
//  Created by Ashwinkumar Mangrulkar on 14/08/18.
//  Copyright © 2018 Ashwinkumar Mangrulkar. All rights reserved.
//

import Foundation
import CoreData

class ClimateWrapper: NSManagedObject
{
    /*
     /Create singleton object of class climateModel
     */
    static let sharedInstance : ClimateWrapper = {
        let instance = ClimateWrapper()
        return instance
    }()
    
    /*
     // Insert record in core data
     */
    func insertRecord(_ climateObj : DTOClimate) -> Bool
    {
        //2
        let entity =  NSEntityDescription.entity(forEntityName: ClimateTable,
                                                 in:managedContext)
        
        let climate = NSManagedObject(entity: entity!,
                                      insertInto: managedContext) as! Climate
        
        climate.countryId = climateObj.countryId
        climate.countryParamId = climateObj.countryParamId
        climate.year = climateObj.year
        climate.jan = climateObj.jan
        climate.feb = climateObj.feb
        climate.mar = climateObj.mar
        climate.apr = climateObj.apr
        climate.may = climateObj.may
        climate.jun = climateObj.jun
        climate.jul = climateObj.jul
        climate.aug = climateObj.aug
        climate.sep = climateObj.sep
        climate.oct = climateObj.oct
        climate.nov = climateObj.nov
        climate.dec = climateObj.dec
        
        do {
            try managedContext.save()
            //                print("Record Saved")
            return true
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        return false
    }
    
    /*
     // fetch all records in core data
     */
    func fetchRecords() -> [DTOClimate]
    {
        // Create object of any object
        var fetchRecordsArray : [DTOClimate] = []
        // Fetching
        //            let fetchRequest = NSFetchRequest()
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: ClimateTable, in:managedContext)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        // Execute Fetch Request
        do {
            let result = try managedContext.fetch(fetchRequest)
            print(result)
            
            if (result.count > 0) {
                
                for index in 0..<result.count
                {
                    let climate : Climate =  result[index] as! Climate
                    
                    let countryid = climate.value(forKey: "countryId") as? Int16
                    let countryParamId = climate.value(forKey: "countryParamId") as? Int16
                    let year = climate.value(forKey: "year") as? String
                    let jan = climate.value(forKey: "jan") as? String
                    let feb = climate.value(forKey: "feb") as? String
                    let mar = climate.value(forKey: "mar") as? String
                    let apr = climate.value(forKey: "apr") as? String
                    let may = climate.value(forKey: "may") as? String
                    let jun = climate.value(forKey: "jun") as? String
                    let jul = climate.value(forKey: "jul") as? String
                    let aug = climate.value(forKey: "aug") as? String
                    let sep = climate.value(forKey: "sep") as? String
                    let oct = climate.value(forKey: "oct") as? String
                    let nov = climate.value(forKey: "nov") as? String
                    let dec = climate.value(forKey: "dec") as? String
                    
                    let dtoClimate = DTOClimate(apr: apr!, aug: aug!, countryId: countryid!, countryParamId: countryParamId!, dec: dec!, feb: feb!, jan: jan!, jul: jul!, jun: jun!, mar: mar!, may: may!, nov: nov!, oct: oct!, sep: sep!, year: year!)
                    
                    fetchRecordsArray.append(dtoClimate)
                }
                return fetchRecordsArray
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return fetchRecordsArray
    }
    
    /*
     // Insert specific record according to id in core data
     */
    func fetchRecordsById(countryId : Int16, paramId: Int16) -> [DTOClimate]
    {
        
        // Create object of any object
        var fetchRecordsArray : [DTOClimate] = []
        
        // Fetching
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName : ClimateTable)
        
        // Create Predicate
        let predicateContry = NSPredicate(format: "countryId == %d", countryId)
        let predicateIsEnabled = NSPredicate(format: "countryParamId == %d", paramId)
        let predicate = NSCompoundPredicate(type: .and, subpredicates: [predicateContry, predicateIsEnabled])
        
        fetchRequest.predicate = predicate
        
        // Add Sort Descriptor
        //            let sortDescriptor1 = NSSortDescriptor(key: "countryParamId", ascending: true)
        //            fetchRequest.sortDescriptors = [sortDescriptor1]
        
        // Execute Fetch Request
        do {
            let result = try managedContext.fetch(fetchRequest)
            print(result)
            
            if (result.count > 0) {
                
                for index in 0..<result.count
                {
                    let climate : Climate =  result[index] as! Climate
                    
                    let countryid = climate.value(forKey: "countryId") as? Int16
                    let countryParamId = climate.value(forKey: "countryParamId") as? Int16
                    let year = climate.value(forKey: "year") as? String
                    let jan = climate.value(forKey: "jan") as? String
                    let feb = climate.value(forKey: "feb") as? String
                    let mar = climate.value(forKey: "mar") as? String
                    let apr = climate.value(forKey: "apr") as? String
                    let may = climate.value(forKey: "may") as? String
                    let jun = climate.value(forKey: "jun") as? String
                    let jul = climate.value(forKey: "jul") as? String
                    let aug = climate.value(forKey: "aug") as? String
                    let sep = climate.value(forKey: "sep") as? String
                    let oct = climate.value(forKey: "oct") as? String
                    let nov = climate.value(forKey: "nov") as? String
                    let dec = climate.value(forKey: "dec") as? String
                    
                    let dtoClimate = DTOClimate(apr: apr!, aug: aug!, countryId: countryid!, countryParamId: countryParamId!, dec: dec!, feb: feb!, jan: jan!, jul: jul!, jun: jun!, mar: mar!, may: may!, nov: nov!, oct: oct!, sep: sep!, year: year!)
                    
                    fetchRecordsArray.append(dtoClimate)
                }
                return fetchRecordsArray
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return fetchRecordsArray
    }
    
    /*
     /Update specific record according to id
     */
    func updateRecordById(countryId : Int16, paramId: Int16) -> Bool {
        
        // Fetching
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName : ClimateTable)
        
        // Create Predicate
        let predicateContry = NSPredicate(format: "countryId == %d", countryId)
        let predicateIsEnabled = NSPredicate(format: "countryParamId == %d", paramId)
        let predicate = NSCompoundPredicate(type: .and, subpredicates: [predicateContry, predicateIsEnabled])
        
        fetchRequest.predicate = predicate
        
        // Add Sort Descriptor
        //            let sortDescriptor1 = NSSortDescriptor(key: "countryParamId", ascending: true)
        //            fetchRequest.sortDescriptors = [sortDescriptor1]
        
        // Execute Fetch Request
        do {
            let result = try managedContext.fetch(fetchRequest)
            print(result)
            
            if (result.count > 0) {
                let climate = result[0] as! Climate
                
                climate.countryId = countryId
                climate.countryParamId = paramId
                
                do {
                    try climate.managedObjectContext?.save()
                    return true
                    
                } catch {
                    let saveError = error as NSError
                    print(saveError)
                }
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return false
    }
    
    
    /*
     /Delete specific record according to id
     */
    func deleteRecordById(contryId : Int16, paramId: Int16) -> Bool
    {
        // Fetching
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName : ClimateTable)
        
        // Create Predicate
        let predicateContry = NSPredicate(format: "countryId == %d", contryId)
        let predicateIsEnabled = NSPredicate(format: "countryParamId == %d", paramId)
        let predicate = NSCompoundPredicate(type: .and, subpredicates: [predicateContry, predicateIsEnabled])
        
        fetchRequest.predicate = predicate
        
        // Add Sort Descriptor
        //            let sortDescriptor1 = NSSortDescriptor(key: "countryParamId", ascending: true)
        //            fetchRequest.sortDescriptors = [sortDescriptor1]
        
        // Execute Fetch Request
        do {
            let result = try managedContext.fetch(fetchRequest)
            print(result)
            
            if (result.count > 0) {
                let climate = result[0] as! Climate
                
                managedContext.delete(climate)
                
                do {
                    try managedContext.save()
                    return true
                    
                } catch {
                    let saveError = error as NSError
                    print(saveError)
                }
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return false
    }
}
