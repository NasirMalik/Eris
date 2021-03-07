//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation
import CoreData

final class Planet: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
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
    
    required convenience init(from decoder: Decoder) throws {
        let context = CoreDataService.shared.mainContext
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
