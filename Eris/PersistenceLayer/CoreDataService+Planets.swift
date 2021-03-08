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
            if let name = $0.name, fetchPlanet(name: name) == nil {
                let planet = Planet(entity: $0.entity, insertInto: context)
                planet.name = $0.name
                planet.terrain = $0.terrain
                planet.rotationPeriod = $0.rotationPeriod
                planet.orbitalPeriod = $0.orbitalPeriod
                planet.diameter = $0.diameter
                planet.climate = $0.climate
                planet.gravity = $0.gravity
                planet.surfaceWater = $0.surfaceWater
                planet.created = $0.created
                planet.edited = $0.edited
                planet.url = $0.url
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
        let context = CoreDataService.shared.backgroundContext()
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


