//
//  Company.swift
//  useray
//
//  Created by Mobile Developer on 8/07/15.
//  Copyright (c) 2015 Juan Felipe Carrera Moya. All rights reserved.
//

import Foundation
import CoreData

class Company: NSManagedObject {

    @NSManaged var bs: String
    @NSManaged var catchPhrase: String
    @NSManaged var name: String
    @NSManaged var user: User

}
