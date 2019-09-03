//
//  Message+CoreDataProperties.swift
//  Facebook_Messanger_clone
//
//  Created by Steven on 2019/9/3.
//  Copyright © 2019 Steven. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var text: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var friend: Friend?

}
