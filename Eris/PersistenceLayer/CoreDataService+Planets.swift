//
//  Created by Nasir Mahmood on 07.03.21.
//

import Foundation
import CoreData

extension CoreDataService {
    
    /*
     Count number of Enteries Available
     */
    func getRecordsCount() -> Int {
        let context = mainContext
        let request: NSFetchRequest<Planet> = Planet.fetchRequest()
        do {
            let count = try context.count(for: request)
            return count
        } catch {
            print(error.localizedDescription)
            return 0
        }
    }
    
    /*
     Reading: Light Weight Operation
     Should be done on main Thread
     */
    func fetchPlanets(page: Int, completion: (Result<[Planet], Error>) -> Void) {
        let context = mainContext
        
        let predicate = NSPredicate(format: "page == %d", page)
        let request: NSFetchRequest<Planet> = Planet.fetchRequest()
        request.predicate = predicate
        
        do {
            let planets = try context.fetch(request)
            completion(.success(planets))
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    /*
     Reading: Heavy Weight Operation
     Should be done on background Thread
     */
    func savePlanets(page: Int, planets: [Planet]) throws {
        let context = backgroundContext
        planets.forEach {
            if let name = $0.name, fetchPlanet(name: name) == nil {
                _ = Planet(object: $0, context: context, page: Int64(page))
            }
        }
        
        do {
            try context.save()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
}

private extension CoreDataService {
    func fetchPlanet(name: String) -> Planet? {
        let context = backgroundContext
        // TODO: This operation should include timestamp to have most recent data in persistence, from a changing source
        let predicate = NSPredicate(format: "name == %@", name)
        
        let request: NSFetchRequest<Planet> = Planet.fetchRequest()
        request.predicate = predicate
        
        do {
            let planetArray = try context.fetch(request)
            return planetArray.first
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
}


