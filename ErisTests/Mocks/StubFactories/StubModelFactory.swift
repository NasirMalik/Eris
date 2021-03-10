//
//  Created by Nasir Mahmood on 10.03.21.
//

import Foundation
@testable import Eris

final class StubModelFactory {
    
    static func modelPlanetObject() -> Planet {
        
        let jsonString = """
        {
            "name": "earth",
            "rotation_period": "36000",
            "orbital_period": "365 days",
            "diameter": "24000",
            "climate": "Modest",
            "gravity": "9.8m/s",
            "terrain": "Land",
            "surfaceWater": "76%",
            "created": "some date",
            "edited": "some date",
            "url": "google.com"
        }
        """
        
        let jsonData = jsonString.data(using: .utf8)!
        return try! JSONDecoder.defaultDecoder.decode(Planet.self, from: jsonData)
        
    }
    
}
