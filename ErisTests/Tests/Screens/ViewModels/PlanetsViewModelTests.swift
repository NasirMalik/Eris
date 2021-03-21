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
        
        XCTAssertEqual(repository.count, 1)
        XCTAssertEqual(repository.getPlanetsCallCount, 1)
        XCTAssertEqual(sut.planets, [stubPlanet.1])
    }
    
    func testDeleteData() {
        let stubPlanet = makePlanetViewData()
        repository.result = .success([stubPlanet.0])
        sut.loadData()
        
        sut.deleteRow(index: 0)
        
        XCTAssertEqual(repository.count, 1)
        XCTAssertEqual(sut.planets.count, 0)
    }
    
}

private extension PlanetsViewModelTests {
    
    func makePlanetViewData() -> (Planet, PlanetViewData) {
        let planet = StubModelFactory.modelPlanetObject()
        let viewData = PlanetViewData.init(name: planet.name!.uppercased(),
                                            terrain: planet.terrain!.capitalized)
        return (planet, viewData)
    }
    
}
