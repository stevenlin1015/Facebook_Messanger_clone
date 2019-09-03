//
//  FriendsControllerHelper.swift
//  Facebook_Messanger_clone
//
//  Created by Steven on 2019/9/3.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit
import CoreData

extension FriendsController {
    
    func clearData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            do {
                
                
                let fetchRequestForFriend: NSFetchRequest<Friend> = Friend.fetchRequest()
                let objectsForFriend = try context.fetch(fetchRequestForFriend)
                for object in objectsForFriend {
                    context.delete(object)
                }
                
                let fetchRequestForMessage: NSFetchRequest<Message> = Message.fetchRequest()
                let objectsForMessage = try context.fetch(fetchRequestForMessage)
                for object in objectsForMessage {
                    context.delete(object)
                }
                
                
                
                try (context.save())
                
            } catch let err {
                print(err)
            }
            
        }
    }
    
    func setupData() {
         clearData()
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            let mark = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            mark.name = "Mark Zuckerberg"
            mark.profileImageName = "zuckprofile"
            
            let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            message.friend = mark
            message.text = "Hello, my name is Mark. Nice to meet you..."
            message.date = NSDate()
            
            let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            steve.name = "Steve Jobs"
            steve.profileImageName = "steveprofile"
            
            let messageSteve = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            messageSteve.friend = steve
            messageSteve.text = "Apple creates great iOS devices for the world..."
            messageSteve.date = NSDate()
            
            do {
                try (context.save())
            } catch let err {
                print(err)
            }
            
            //messages = [message, messageSteve]
        }
        
        loadData()
        
        
    }
    
    func loadData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            let fetchRequest: NSFetchRequest<Message> = Message.fetchRequest()
            
            do {
                messages = try context.fetch(fetchRequest)
            } catch let err {
                print(err)
            }
            
        }
    }
    
}
