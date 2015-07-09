//
//  AppModel.swift
//  useray
//
//  Created by Mobile Developer on 8/07/15.
//  Copyright (c) 2015 Juan Felipe Carrera Moya. All rights reserved.
//

import Foundation
import CoreData

class AppModel {
    
    var managedObjectContext:NSManagedObjectContext?
    var userAPI:UserClientAPI?
    var localDataManager:LocalDataManager?
    
    init()
    {
        userAPI = UserClientAPI()
        self.managedObjectContext = userAPI!.managedObjectContext
        localDataManager = LocalDataManager.sharedInstance
        localDataManager?.managedObjectContext = userAPI!.managedObjectContext
    }
    
    func importUsers(completion:()-> Void)
    {
        userAPI!.loadUsers(({
            
            completion()
            
        }))
    }
    
    func loadUsers() -> [AnyObject]
    {
        return localDataManager!.loadUsers()
    }
    
}
