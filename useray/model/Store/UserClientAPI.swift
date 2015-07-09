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
        
//        NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
//        RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
//        NSError *error = nil;
//        BOOL success = RKEnsureDirectoryExistsAtPath(RKApplicationDataDirectory(), &error);
//        if (! success) {
//            RKLogError(@"Failed to create Application Data Directory at path '%@': %@", RKApplicationDataDirectory(), error);
//        }
//        NSString *path = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"Store.sqlite"];
//        NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:path fromSeedDatabaseAtPath:nil withConfiguration:nil options:nil error:&error];
//        if (! persistentStore) {
//            RKLogError(@"Failed adding persistent store at path '%@': %@", path, error);
//        }
//        [managedObjectStore createManagedObjectContexts];
        

    
        let baseURL:NSURL = NSURL(string: baseURLString)!
        objectManager = RKObjectManager(baseURL: baseURL)
        
        var managedObjectModel = NSManagedObjectModel.mergedModelFromBundles(nil)
        var managedObjectStore = RKManagedObjectStore(managedObjectModel: managedObjectModel)
        managedObjectStore.createPersistentStoreCoordinator()
        var error:NSError?
        let success = RKEnsureDirectoryExistsAtPath(RKApplicationDataDirectory(), &error)
        if !success {
            NSLog("Failed to create application Data directory at path %@: %@",RKApplicationDataDirectory(), error!)
        }
        
        let path = RKApplicationDataDirectory()+"/Useray.sqlite"
        let persistentStore = managedObjectStore.addSQLitePersistentStoreAtPath(path, fromSeedDatabaseAtPath: nil, withConfiguration: nil, options: nil, error: &error)

        managedObjectStore.createManagedObjectContexts()
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
        return RKApplicationDataDirectory().stringByAppendingPathComponent("Useray.sqlite")
    }
    
    private func databasePath() -> String
    {
        let fileUrl = NSBundle.mainBundle().pathForResource("Useray", ofType: "momd")!
        return fileUrl
    }
    
}