//
//  File.swift
//  
//
//  Created by Nasir Mahmood on 09.03.21.
//

import Foundation

struct MockPlanet: Codable, Equatable {
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

struct MockResponse: Equatable {
    let count: Int
    let planets: [MockPlanet]
    let next: String?
    let previous: String?
}

extension MockResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case count
        case planets = "results"
        case next
        case previous
    }
}

