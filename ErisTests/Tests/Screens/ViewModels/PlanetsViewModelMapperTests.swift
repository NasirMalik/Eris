//
//  Created by Nasir Mahmood on 10.03.21.
//

import Foundation
import XCTest
@testable import Eris

final class PlanetsViewModelMapperTests: XCTestCase {
    
    var sut: PlanetsViewModelMapper!
    
    override class func setUp() {
        super.setUp()
    }
    
    func testMap() {
        let planet = StubModelFactory.modelPlanetObject()
        
        let viewData = sut.map(model: planet)
        
        XCTAssertNotNil(viewData)
        XCTAssertEqual(viewData.name, "earth".uppercased())
        XCTAssertEqual(viewData.rotationPeriod, "36000")
        XCTAssertEqual(viewData.orbitalPeriod, "365 days")
        XCTAssertEqual(viewData.diameter, "24000")
        XCTAssertEqual(viewData.climate, "Modest".capitalized)
        XCTAssertEqual(viewData.gravity, "9.8m/s")
        XCTAssertEqual(viewData.terrain, "Land".capitalized)
        XCTAssertEqual(viewData.surfaceWater, "76%")
        XCTAssertEqual(viewData.created, "some date")
        XCTAssertEqual(viewData.edited, "some date")
        XCTAssertEqual(viewData.url, "google.com")
    }
}
