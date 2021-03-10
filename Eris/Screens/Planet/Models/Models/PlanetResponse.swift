//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation

struct Response {
    var count: Int = 0
    var planets: [Planet] = []
    var next: String?
    var previous: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.count = try container.decode(Int.self, forKey: .count)
        self.planets = try container.decode([Planet].self, forKey: .planets)
        self.next = try container.decode(String?.self, forKey: .next)
        self.previous = try container.decode(String?.self, forKey: .previous)
    }
}

extension Response: Decodable {
    enum CodingKeys: String, CodingKey {
        case count
        case planets = "results"
        case next
        case previous
    }
}
