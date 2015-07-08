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
    
    init()
    {
        userAPI = UserClientAPI()
        self.managedObjectContext = userAPI!.managedObjectContext
    }
    
    func importUsers(completion:()-> Void)
    {
        userAPI!.loadUsers(({
            
            completion()
            
        }))
    }
    
    func loadUsers() -> [NSManagedObject]
    {
        return LocalDataManager.sharedInstance.loadUsers()
    }
    
}
