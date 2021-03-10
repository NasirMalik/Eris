//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation

struct Response {
    let count: Int
    let planets: [Planet]
    let next: String?
    let previous: String?
}

extension Response: Decodable {
    enum CodingKeys: String, CodingKey {
        case count
        case planets = "results"
        case next
        case previous
    }
}
