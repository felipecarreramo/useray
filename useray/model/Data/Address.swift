//
//  Address.swift
//  useray
//
//  Created by Mobile Developer on 8/07/15.
//  Copyright (c) 2015 Juan Felipe Carrera Moya. All rights reserved.
//

import Foundation
import CoreData

class Address: NSManagedObject {

    @NSManaged var city: String
    @NSManaged var street: String
    @NSManaged var suite: String
    @NSManaged var zipcode: String
    @NSManaged var user: User
    @NSManaged var geo: Geo

}
