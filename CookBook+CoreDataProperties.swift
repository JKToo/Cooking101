//
//  CookBook+CoreDataProperties.swift
//  Cook Book
//
//  Created by Justin on 4/16/22.
//
//

import Foundation
import CoreData


extension CookBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CookBook> {
        return NSFetchRequest<CookBook>(entityName: "CookBook")
    }

    @NSManaged public var recipes: String?
    @NSManaged public var details: String?
}

extension CookBook : Identifiable {

}
