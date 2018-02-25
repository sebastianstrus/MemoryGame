//
//  CoreData.swift
//  Foody
//
//  Created by Sebastian Strus on 2017-12-04.
//  Copyright © 2017 Sebastian Strus. All rights reserved.
//
import UIKit
import CoreData
import Foundation

class CoreData: NSObject {
    
    class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    class func saveUser(username:String, score:Int32) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Player", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        manageObject.setValue(username, forKey: "username")
        manageObject.setValue(score, forKey: "score")

        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    class func getUsers() -> [Player]? {
        let context = getContext()
        var users:[Player]? = nil
        do {
            users = try context.fetch(Player.fetchRequest())
            return users
        } catch {
            return users
        }
    }
    
    class func deleteUser(user: Player) -> Bool {
        let context = getContext()
        context.delete(user)
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    class func cleanDelete() -> Bool {
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: Player.fetchRequest())
        do {
            try context.execute(delete)
            return true
        } catch {
            return false
        }
    }
    
//    class func getUser(email:String) -> Player? {
//        let context = getContext()
//        let fetchRequest:NSFetchRequest<Player> = User.fetchRequest()
//        var user:Player? = nil
//        var users:[Player]? = nil
//        let predicate = NSPredicate(format: "email == %@", email)
//        fetchRequest.predicate = predicate
//        do {
//            users = try context.fetch(fetchRequest)
//            if let count = users?.count, count > 0 {
//                user = users?[0]
//            }
//            return user
//        } catch {
//            return user
//        }
//    }
}

