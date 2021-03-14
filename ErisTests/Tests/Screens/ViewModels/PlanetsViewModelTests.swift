//
//  Created by Nasir Mahmood on 10.03.21.
//

import Foundation
import XCTest
@testable import Eris

final class PlanetsViewModelTests: XCTestCase {
    
    var repository: PlanetsRepositoryMock!
    var sut: PlanetsViewModel!
    
    override func setUp() {
        super.setUp()
        self.repository = PlanetsRepositoryMock()
        self.sut = PlanetsViewModelImpl(resository: repository,
                                       onCompletion: { _ in })
    }
    
    func testLoadData() {
        let stubPlanet = makePlanetViewData()
        repository.result = .success([stubPlanet.0])
        
        sut.loadData()
        
        XCTAssertEqual(repository.getPlanetsCallCount, 1)
        XCTAssertEqual(sut.planets, [stubPlanet.1])
    }
    
}

private extension PlanetsViewModelTests {
    
    func makePlanetViewData() -> (Planet, PlanetsViewData) {
        let planet = StubModelFactory.modelPlanetObject()
        let viewData = PlanetsViewData.init(name: planet.name!.uppercased(),
                                            terrain: planet.terrain!.capitalized)
        return (planet, viewData)
    }
    
}


