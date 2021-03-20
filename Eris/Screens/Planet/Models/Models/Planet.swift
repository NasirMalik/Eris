//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation
import CoreData

final class Planet: NSManagedObject {
    // CoreData Generated Model
    convenience init(object: Planet, context: NSManagedObjectContext, page: Int64) {
        self.init(entity: object.entity, insertInto: context)
        self.page = page
        self.name = object.name
        self.terrain = object.terrain
        self.rotationPeriod = object.rotationPeriod
        self.orbitalPeriod = object.orbitalPeriod
        self.diameter = object.diameter
        self.climate = object.climate
        self.gravity = object.gravity
        self.surfaceWater = object.surfaceWater
        self.created = object.created
        self.edited = object.edited
        self.url = object.url
    }
}

extension Planet: Decodable {
    enum CodingKeys: CodingKey {
        case page
        case name
        case rotationPeriod
        case orbitalPeriod
        case diameter
        case climate
        case gravity
        case terrain
        case surfaceWater
        case created
        case edited
        case url
    }
    
    convenience init(from decoder: Decoder) throws {
        let context = CoreDataService.instance.mainContext
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.rotationPeriod = try container.decode(String.self, forKey: .rotationPeriod)
        self.orbitalPeriod = try container.decode(String.self, forKey: .orbitalPeriod)
        self.diameter = try container.decode(String.self, forKey: .diameter)
        self.climate = try container.decode(String.self, forKey: .climate)
        self.gravity = try container.decode(String.self, forKey: .gravity)
        self.terrain = try container.decode(String.self, forKey: .terrain)
        self.surfaceWater = try container.decode(String.self, forKey: .surfaceWater)
        self.created = try container.decode(String.self, forKey: .created)
        self.edited = try container.decode(String.self, forKey: .edited)
        self.url = try container.decode(String.self, forKey: .url)
    }
    
}
