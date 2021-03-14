//
//  Created by Nasir Mahmood on 07.03.21.
//

import Foundation
import CoreData

extension CoreDataService {
    /*
     Reading: Light Weight Operation
     Should be done on main Thread
     */
    func fetchPlanets(completion: (Result<[Planet], Error>) -> Void) {
        let context = mainContext
        let request: NSFetchRequest<Planet> = Planet.fetchRequest()
        
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
    func savePlanets(planets: [Planet]) throws {
        let context = backgroundContext
        planets.forEach {
            if let name = $0.name, fetchPlanet(name: name) == nil {
                _ = Planet(object: $0, context: context)
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


