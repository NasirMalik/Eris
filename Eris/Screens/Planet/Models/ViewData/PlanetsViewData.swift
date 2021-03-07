//
//  Created by Nasir Mahmood on 07.03.21.
//

import Foundation

struct PlanetsViewData {
    let name: String
    let detail: String
    
    var icon: String {
        return String(format: "planet_%d", Int.random(in: 0...11))
    }
}
