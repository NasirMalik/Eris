//
//  Created by Nasir Mahmood on 07.03.21.
//

import Foundation
import CoreData

enum StorageType {
    case persistent, inMemory
}

final class CoreDataService {
    
    static var instance: CoreDataService!
        
    private let persistentContainer: NSPersistentContainer
    
    init(_ storageType: StorageType = .persistent) {
        self.persistentContainer = NSPersistentContainer(name: "Eris")
        
        if storageType == .inMemory {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            self.persistentContainer.persistentStoreDescriptions = [description]
        }
        
        self.persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        CoreDataService.instance = self
    }
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
     
    /*
     To be used for long running data saving operation
     */
    var backgroundContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
}
