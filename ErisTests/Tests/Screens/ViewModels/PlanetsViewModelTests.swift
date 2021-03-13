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
        let planet = StubModelFactory.modelPlanetObject()
        repository.result = .success([planet])
        
        sut.loadData()
        
        XCTAssertEqual(repository.getPlanetsCallCount, 1)
        XCTAssertEqual(sut.planets, [planet])
    }
}


