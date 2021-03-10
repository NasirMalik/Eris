//
//  Created by Nasir Mahmood on 10.03.21.
//

import Foundation
import XCTest
@testable import Eris

final class PlanetsViewModelTests: XCTestCase {
    
    func testLoadData() {
        let repository = PlanetsRepositoryMock()
        let sut = PlanetsViewModelImpl(resository: repository,
                                       onCompletion: { _ in })
        
        let planet = StubModelFactory.modelPlanetObject()
        repository.result = .success([planet])
        
        sut.loadData()
        
        XCTAssertEqual(repository.getPlanetsCallCount, 1)
        XCTAssertEqual(sut.planets, [planet])
    }
}


