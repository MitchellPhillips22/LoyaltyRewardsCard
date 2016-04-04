//
//  LatteStar+CoreDataProperties.swift
//  LoyaltyCard(Simple)
//
//  Created by Mitchell Phillips on 4/4/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension LatteStar {

    @NSManaged var isSelected: NSNumber?
    @NSManaged var numberOfSelectedStars: NSNumber?

}
