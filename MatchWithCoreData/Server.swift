//
//  Server.swift
//  MatchWithCoreData
//
//  Created by Immadope on 6/24/15.
//  Copyright © 2015 Immadope. All rights reserved.
//

import UIKit
import CoreData

@objc(Server)
class Server: NSManagedObject {
    
    @NSManaged var serverId : String
    @NSManaged var serverName : String
    @NSManaged var rangeIp : String
    @NSManaged var serverDateAdded : NSDate
}
