//
//  Created by Nasir Mahmood on 10.03.21.
//

import Foundation
import XCTest
@testable import Eris

final class PlanetsRepositoryTests: XCTestCase {
    
    var interactor: PlanetsInteractorMock!
    var sut: PlanetsRepositoryImpl!
    
    override func setUp() {
        super.setUp()
        interactor = PlanetsInteractorMock()
        
        sut = PlanetsRepositoryImpl(interactor: interactor,
                                    persistor: CoreDataService.shared,
                                    networkCheck: NetworkCheckService.shared)
    }
    
    func testDataFetchWithNetwork() {
        sut.networkAvailable = true
        
        let responseObject = StubModelFactory.modelResponseObject()
        interactor.result = .success(responseObject)
                
        expectation { exp in
            self.sut.getPlanets { result in
                XCTAssertTrue(Thread.isMainThread)
                switch result {
                    case .success(let response):
                        XCTAssertEqual(response, responseObject.planets)
                    case .failure(let error):
                        XCTAssertNil(error)
                }
                
                exp.fulfill()
            }
        }
    }
    
}
