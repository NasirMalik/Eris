//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation

struct Planet: Decodable {
    let name: String?
    let rotationPeriod: Int?
    let orbitalpPeriod: Int?
    let diameter: String?
    let climate: String?
    let gravity: String?
    let terrain: String?
    let surfaceWater: String?
    let population: String?
    let residents: [String]?
    let films: [String]?
    let created: String?
    let edited: String?
    let url: String?
}
