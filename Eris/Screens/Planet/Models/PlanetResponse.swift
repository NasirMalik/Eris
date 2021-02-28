//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation

struct PlanetResponse {
    let count: Int
    let planets: [Planet]
    let next: String?
    let previous: String?
}

extension PlanetResponse: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case count
        case planets = "result"
        case next
        case previous
    }
}
