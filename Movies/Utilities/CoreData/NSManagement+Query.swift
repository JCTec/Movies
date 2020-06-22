//
//  NSManagement+Query.swift
//  Movies
//
//  Created by Juan Carlos on 22/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    @available(iOS 13.0, *)
    static func query<T: NSManagedObject>(table: String, searchPredicate: NSPredicate) throws -> [T] {
        let context = AppDelegate.current().persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: table)
        fetchRequest.predicate = searchPredicate
        let results = try context.fetch(fetchRequest)
        return results
    }
}
