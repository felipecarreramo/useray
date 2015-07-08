//
//  User.swift
//  useray
//
//  Created by Mobile Developer on 8/07/15.
//  Copyright (c) 2015 Juan Felipe Carrera Moya. All rights reserved.
//

import Foundation
import CoreData

@objc(User)

class User: NSManagedObject {

    @NSManaged var identifier: NSNumber
    @NSManaged var name: String
    @NSManaged var phone: String
    @NSManaged var username: String
    @NSManaged var website: String
    @NSManaged var email: String
    @NSManaged var address: Address?
    @NSManaged var company: Company?

}
