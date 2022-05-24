//
//  Twitter+CoreDataProperties.swift
//  TwitterSeaches
//
//  Created by LABORATORIOS on 24/5/22.
//
//

import Foundation
import CoreData


extension Twitter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Twitter> {
        return NSFetchRequest<Twitter>(entityName: "Twitter")
    }

    @NSManaged public var name: String?
    @NSManaged public var twitter: String?

}

extension Twitter : Identifiable {

}
