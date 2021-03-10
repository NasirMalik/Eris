//
//  Created by Nasir Mahmood on 10.03.21.
//

import Foundation

final class StubModelFactory {
    
    static func modelData() -> Data {
        let response = modelObject()
        return try! JSONEncoder().encode(response)
    }
    
    static func modelObject() -> StubResponse {
        let planet = StubPlanet.init(name: "",
                                     rotationPeriod: "",
                                     orbitalPeriod: "",
                                     diameter: "",
                                     climate: "",
                                     gravity: "",
                                     terrain: "",
                                     surfaceWater: "",
                                     created: "",
                                     edited: "",
                                     url: "")
        
        return StubResponse(count: 1,
                            planets: [planet],
                            next: nil,
                            previous: nil)
    }
    
}
