//
//  CoreDataManager.swift
//  CopyIII(1)
//
//  Created by Denis Polishchuk on 01.07.2022.
//

import CoreData


class CoreDataManager {
    static let shared = CoreDataManager.init()
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CopyIII(1)")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

//MARK: - Create Objc -
extension CoreDataManager {
    func createChair() -> Chair {
        let chair = Chair.init(context: persistentContainer.viewContext)
        return chair
    }
}

//MARK: - Get -
extension CoreDataManager {
    func getChairs() -> [Chair] {
        let fetchReques = NSFetchRequest<Chair>(entityName: "Chair")
        let sortDescriptor = NSSortDescriptor.init(key: #keyPath(Chair.name), ascending: true)
        fetchReques.sortDescriptors = [sortDescriptor]
        do {
            let chairs = try persistentContainer.viewContext.fetch(fetchReques)
            return chairs
        } catch {
            fatalError("\(error)")
        }
    }
    
    func getFavoriteChairs() -> [Chair] {
        let fetchRequest = NSFetchRequest<Chair>(entityName: "Chair")
        let sortDescriptor = NSSortDescriptor.init(key: #keyPath(Chair.name), ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let predicate = NSPredicate.init(format: "isFavorite == YES")
        fetchRequest.predicate = predicate
        do {
            let chair = try persistentContainer.viewContext.fetch(fetchRequest)
            return chair
        } catch {
            fatalError("\(error)")
        }
    }
}

//MARK: - Delete -
extension CoreDataManager {
    func deleteObjc(chair: Chair) {
        self.persistentContainer.viewContext.delete(chair)
        self.saveContext()
    }
}
