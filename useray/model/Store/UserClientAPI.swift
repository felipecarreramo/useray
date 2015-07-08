//
//  UserClientAPI.swift
//  useray
//
//  Created by Mobile Developer on 8/07/15.
//  Copyright (c) 2015 Juan Felipe Carrera Moya. All rights reserved.
//

import Foundation
import CoreData

class UserClientAPI {
    
    let baseURLString = "http://jsonplaceholder.typicode.com"
    var objectManager: RKObjectManager?
    var managedObjectContext:NSManagedObjectContext?
    
    init()
    {
        self.setupRestKit()
    }
    
    private func  setupRestKit()
    {
    
        let baseURL:NSURL = NSURL(string: baseURLString)!
        objectManager = RKObjectManager(baseURL: baseURL)
        var managedObjectModel = NSManagedObjectModel.mergedModelFromBundles(nil)
        var managedObjectStore = RKManagedObjectStore(managedObjectModel: managedObjectModel)
       
        
        managedObjectStore.createPersistentStoreCoordinator()
        var error:NSError?
        let persistentStore: NSPersistentStore = managedObjectStore.addSQLitePersistentStoreAtPath(self.storePath(), fromSeedDatabaseAtPath: self.databasePath(), withConfiguration: nil, options: nil, error: &error)
        
        if error != nil {
            
            NSLog("Failed to add persistent store with Error: %@", error!)
        }
        
        managedObjectStore.createManagedObjectContexts()
        managedObjectStore.managedObjectCache = RKInMemoryManagedObjectCache(managedObjectContext: managedObjectStore.persistentStoreManagedObjectContext)
        
        objectManager!.managedObjectStore = managedObjectStore
        
        managedObjectContext = managedObjectStore.persistentStoreManagedObjectContext

        
        
        let userEntityDescription:NSEntityDescription = NSEntityDescription.entityForName("User", inManagedObjectContext: managedObjectStore.persistentStoreManagedObjectContext)!
        let userMapping:RKEntityMapping = RKEntityMapping(entity: userEntityDescription)
        userMapping.identificationAttributes = ["identifier"]
        
        userMapping.addAttributeMappingsFromDictionary([
            
                "id":"identifier",
                "name":"name",
                "phone":"phone",
                "username":"username",
                "website":"website",
                "email":"email",
            ])
        let userResponseDescriptor = RKResponseDescriptor(
            mapping: userMapping,
            method: RKRequestMethod.GET,
            pathPattern: "/users",
            keyPath: nil,
            statusCodes: NSIndexSet(index: 200))
        
        objectManager!.addResponseDescriptor(userResponseDescriptor)
        
    }
    
    func loadUsers(completion:() -> Void)
    {
        objectManager?.getObjectsAtPath(
            "/users",
            parameters: nil,
            success: { (RKObjectRequestOperation operation, RKMappingResult mappingResult) -> Void in
                completion()
            },
            failure: { (RKObjectRequestOperation operation, NSError error) -> Void in
            
            }
        )
    }
    
    private func storePath() -> String
    {
        return RKApplicationDataDirectory().stringByAppendingPathComponent("useray.sqlite")
    }
    
    private func databasePath() -> String
    {
        let fileUrl = NSBundle.mainBundle().pathForResource("useray", ofType: "momd")!
        return fileUrl
    }
    
}