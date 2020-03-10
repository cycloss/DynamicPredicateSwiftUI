//
//  User+CoreDataProperties.swift
//  CoreDataGuideV2
//
//  Created by Edward Lucas-Rowe on 26/02/2020.
//  Copyright © 2020 Edward Lucas-Rowe. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    
    var idUw: UUID {
        id ?? UUID()
    }
    
    var nameUw: String {
        name ?? "Unknown user"
    }
    
    var ageUw: Int {
        Int(age)
    }

}
