//
//  Contact+CoreDataProperties.swift
//  My Contact List
//
//  Created by Marc Turner on 4/5/23.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var birthday: Date?
    @NSManaged public var cellNumber: String?
    @NSManaged public var city: String?
    @NSManaged public var contactName: String?
    @NSManaged public var email: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var state: String?
    @NSManaged public var streetAddress: String?
    @NSManaged public var zipCode: String?

}

extension Contact : Identifiable {

}
