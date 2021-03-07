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
        let context = CoreDataService.shared.mainContext
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
        let context = CoreDataService.shared.backgroundContext()
        planets.forEach {
            // TODO: Check if entity exists then update
            
            let planet = Planet(entity: $0.entity, insertInto: context)
            planet.name = $0.name
            planet.terrain = $0.terrain
            
            // TODO: Set all properties
        }
        
        do {
            try context.save()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
}
