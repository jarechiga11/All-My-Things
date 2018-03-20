//
//  Item.swift
//  AMT
//
//  Created by Jesus Arechiga on 4/23/15.
//  Copyright (c) 2015 RAD. All rights reserved.
//


import Foundation
import CoreData

class Item:NSManagedObject {
    @NSManaged var name:String!
    @NSManaged var dateOfPurchase:String!
    @NSManaged var price:String!
    @NSManaged var descriptionItem:String!
    @NSManaged var list:String!
    @NSManaged var picture:NSData!
    @NSManaged var isBorrowed:NSNumber!
}