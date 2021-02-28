//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation

struct Planet: Decodable, Equatable {
    
    let name: String
    let rotationPeriod: Int
    let orbitalpPeriod: Int
    let diameter: Int
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let population: Int64
    let residents: [String]
    let films: [String]
    let created: Date
    let edited: Date
    let url: String
    
}
