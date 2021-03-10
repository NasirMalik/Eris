//
//  File.swift
//  
//
//  Created by Nasir Mahmood on 10.03.21.
//

import Foundation

final class StubModel {
    
    static func modelData() -> Data {
        let jsonObject: [[String: String]]  = [
            [
                 "name": "any name",
                 "rotation_period": "100",
                 "orbital_period": "100",
                 "diameter": "1122",
                 "climate": "snow",
                 "gravity": "1200",
                 "terrain": "Mountains",
                 "surfaceWater": "24%",
                 "created": "DD:MM:YY:TT:SS",
                 "edited": "DD:MM:YY:TT:SS",
                 "url": "https://google.com"
            ]
        ]
        
        return try! JSONEncoder().encode(jsonObject)
    }
    
}
