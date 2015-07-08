//
//  Geo.swift
//  useray
//
//  Created by Mobile Developer on 8/07/15.
//  Copyright (c) 2015 Juan Felipe Carrera Moya. All rights reserved.
//

import Foundation
import CoreData

class Geo: NSManagedObject {

    @NSManaged var lat: NSNumber
    @NSManaged var lng: NSNumber
    @NSManaged var address: Address

}
