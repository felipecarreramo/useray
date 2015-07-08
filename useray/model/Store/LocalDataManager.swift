//
//  LocalDataManager.swift
//  useray
//
//  Created by Mobile Developer on 8/07/15.
//  Copyright (c) 2015 Juan Felipe Carrera Moya. All rights reserved.
//

import Foundation
import CoreData

class LocalDataManager {
    
    var managedObjectContext:NSManagedObjectContext?
    static let sharedInstance = LocalDataManager()
    
    func loadUsers() -> [NSManagedObject]
    {
        let fetchRequest:NSFetchRequest = NSFetchRequest(entityName: "User")
        var error : NSError?
        let fetchedResults = self.managedObjectContext!.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        return fetchedResults!
    }
    
}
