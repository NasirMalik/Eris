//
//  Created by Nasir Mahmood on 09.03.21.
//

import Foundation

struct StubPlanet: Codable, Equatable {
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let created: String
    let edited: String
    let url: String
}

struct StubResponse: Equatable {
    let count: Int
    let planets: [StubPlanet]
    let next: String?
    let previous: String?
}

extension StubResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case count
        case planets = "results"
        case next
        case previous
    }
}

