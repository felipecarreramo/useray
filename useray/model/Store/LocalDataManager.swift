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
    
    func loadUsers() -> [AnyObject]
    {
        
        var fetchRequest = NSFetchRequest(entityName: "User")
        var error : NSError?
        var fetchedResults = self.managedObjectContext!.executeFetchRequest(fetchRequest, error: &error)
        return fetchedResults!
    }
    
}
