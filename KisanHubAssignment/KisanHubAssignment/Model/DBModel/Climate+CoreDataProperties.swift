//
//  Climate+CoreDataProperties.swift
//  
//
//  Created by Ashwinkumar Mangrulkar on 15/08/18.
//
//

import Foundation
import CoreData


extension Climate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Climate> {
        return NSFetchRequest<Climate>(entityName: "Climate")
    }

    @NSManaged public var apr: String?
    @NSManaged public var aug: String?
    @NSManaged public var countryId: Int16
    @NSManaged public var dec: String?
    @NSManaged public var feb: String?
    @NSManaged public var jan: String?
    @NSManaged public var jul: String?
    @NSManaged public var jun: String?
    @NSManaged public var mar: String?
    @NSManaged public var may: String?
    @NSManaged public var nov: String?
    @NSManaged public var oct: String?
    @NSManaged public var sep: String?
    @NSManaged public var year: String?
    @NSManaged public var countryParamId: Int16
    @NSManaged public var relationship: Climate?

}
