//
//  Match.swift
//  MatchWithCoreData
//
//  Created by Immadope on 6/24/15.
//  Copyright © 2015 Immadope. All rights reserved.
//

import UIKit
import CoreData

@objc(Match)
class Match: NSManagedObject {
    
    @NSManaged var matchId : String
    @NSManaged var matchName : String
    @NSManaged var matchDescription : String
}
