//
//  Player+CoreDataProperties.swift
//  MemoryGame
//
//  Created by Sebastian Strus on 2018-02-22.
//  Copyright © 2018 Sebastian Strus. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var score: Int32
    @NSManaged public var username: String?

}
