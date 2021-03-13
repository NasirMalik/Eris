//
//  Created by Nasir Mahmood on 07.03.21.
//

import Foundation

struct PlanetsViewData: Equatable {
    let name: String
    let terrain: String
    
    var icon: String {
        return String(format: "planet_%d", Int.random(in: 0...11))
    }
}
