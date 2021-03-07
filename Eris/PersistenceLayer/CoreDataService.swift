//
//  Created by Nasir Mahmood on 07.03.21.
//

import Foundation
import CoreData

final class CoreDataService {
    /*
     Should not be used as singelton but properly injected
     */
    static let shared = CoreDataService()
    
    private init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Eris")
        container.loadPersistentStores(completionHandler: { _, error in
            _ = error.map { fatalError("Unresolved error \($0)") }
        })
        
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    /*
     To be used for long running data saving operation after fetch
     */
    func backgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
}
