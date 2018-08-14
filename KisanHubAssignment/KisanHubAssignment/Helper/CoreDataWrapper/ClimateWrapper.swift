//
//  ClimateWrapper.swift
//  KisanHubAssignment
//
//  Created by Ashwinkumar Mangrulkar on 14/08/18.
//  Copyright © 2018 Ashwinkumar Mangrulkar. All rights reserved.
//

import Foundation
import CoreData

let managedContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext

class ClimateWrapper: NSManagedObject
{
    /*
     /Create singleton object of class EmployeeModel
     */
    static let sharedInstance : ClimateWrapper = {
        let instance = ClimateWrapper()
        return instance
    }()
    
        /*
         // Insert record in core data
         */
        func insertRecord(_ employeeObj : DTOEmployee) -> Bool
        {
            //2
            let entity =  NSEntityDescription.entity(forEntityName: "Climate",
                in:managedContext)
            
            let employee = NSManagedObject(entity: entity!,
                insertInto: managedContext) as! Climate
            
            employee.emp_id = employeeObj.emp_id
            employee.emp_name = employeeObj.emp_name
            employee.emp_age = employeeObj.emp_age
            
            //4
            do {
                try managedContext.save()
                //5
                print("Record Saved")
                return true
                
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            return false
        }
        
        /*
         // fetch all records in core data
         */
        func fetchRecords() -> [DTOEmployee]
        {
            // Create object of any object
            var fetchRecordsArray : [DTOEmployee] = []
            // Fetching
//            let fetchRequest = NSFetchRequest()
            let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()

            // Create Entity Description
            let entityDescription = NSEntityDescription.entity(forEntityName: "Climate", in:managedContext)
            
            // Configure Fetch Request
            fetchRequest.entity = entityDescription
            
            // Execute Fetch Request
            do {
                let result = try managedContext.fetch(fetchRequest)
                print(result)
                
                if (result.count > 0) {
                    
                    for index in 0..<result.count
                    {
                        let employee : Climate =  result[index] as! Climate
                        
                        var dtoEmployee : DTOEmployee = DTOEmployee()
                        dtoEmployee.emp_id = employee.value(forKey: "emp_id") as? String
                        dtoEmployee.emp_name = employee.value(forKey: "emp_name") as? String
                        dtoEmployee.emp_age = employee.value(forKey: "emp_age") as? String
                        
                        fetchRecordsArray.append(dtoEmployee)
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
        func fetchRecordsById(_ id : String) -> DTOEmployee
        {
            var dtoEmployee = DTOEmployee()
            
            // Fetching
            let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName : "Climate")
            
            // Create Predicate
            let predicate = NSPredicate(format: "%K == %@", "emp_id", id)
            fetchRequest.predicate = predicate
            
            // Add Sort Descriptor
            let sortDescriptor1 = NSSortDescriptor(key: "emp_id", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor1]
            
            // Execute Fetch Request
            do {
                let result = try managedContext.fetch(fetchRequest)
                print(result)
                
                if (result.count > 0) {
                    let employee = result[0] as! EmployeeModel
                    
                    dtoEmployee.emp_id = employee.value(forKey: "emp_id") as? String
                    dtoEmployee.emp_name = employee.value(forKey: "emp_name") as? String
                    dtoEmployee.emp_age = employee.value(forKey: "emp_age") as? String
                    
                    return dtoEmployee
                }
                
            } catch {
                let fetchError = error as NSError
                print(fetchError)
            }
            return dtoEmployee
        }
        
        /*
         /Update specific record according to id
         */
        func updateRecordById(_ dto : DTOEmployee) -> Bool {
            
            // Fetching
            let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName : "Climate")
            
            // Create Predicate
            let predicate = NSPredicate(format: "%K == %@", "emp_id", dto.emp_id!)
            fetchRequest.predicate = predicate
            
            // Add Sort Descriptor
            let sortDescriptor1 = NSSortDescriptor(key: "emp_id", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor1]
            
            // Execute Fetch Request
            do {
                let result = try managedContext.fetch(fetchRequest)
                print(result)
                
                if (result.count > 0) {
                    let employee = result[0] as! EmployeeModel
                    
                    employee.emp_id = dto.emp_id!
                    employee.emp_name = dto.emp_name!
                    employee.emp_age = dto.emp_age!
                    
                    do {
                        try employee.managedObjectContext?.save()
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
        func deleteRecordById(_ id : String) -> Bool
        {
            // Fetching
            let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName : "Climate")
            
            // Create Predicate
            let predicate = NSPredicate(format: "%K == %@", "emp_id", id)
            fetchRequest.predicate = predicate
            
            // Add Sort Descriptor
            let sortDescriptor1 = NSSortDescriptor(key: "emp_id", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor1]
            
            // Execute Fetch Request
            do {
                let result = try managedContext.fetch(fetchRequest)
                print(result)
                
                if (result.count > 0) {
                    let employee = result[0] as! EmployeeModel
                    
                    managedContext.delete(employee)
                    
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
