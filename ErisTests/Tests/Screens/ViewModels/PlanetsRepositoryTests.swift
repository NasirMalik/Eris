//
//  Created by Nasir Mahmood on 10.03.21.
//

import Foundation
import XCTest
@testable import Eris

final class PlanetsRepositoryTests: XCTestCase {
    
    var coreDataService: CoreDataService!
    var interactor: PlanetsInteractorMock!
    var sut: PlanetsRepositoryImpl!
    
    override func setUp() {
        super.setUp()
        coreDataService = CoreDataService(.inMemory)
        interactor = PlanetsInteractorMock()
        
        sut = PlanetsRepositoryImpl(interactor: interactor,
                                    persistor: coreDataService,
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
                        XCTAssertEqual(self.interactor.getPlanetsCallCount, 1)
                        XCTAssertEqual(response, responseObject.planets)
                    case .failure(let error):
                        XCTAssertNil(error)
                }
                
                exp.fulfill()
            }
        }
    }
    
    func testDataFetchWithoutNetwork() {
        sut.networkAvailable = false
        let responseObject = StubModelFactory.modelResponseObject()
        interactor.result = .success(responseObject)
        
        try! coreDataService.savePlanets(planets: responseObject.planets)
                
        expectation { exp in
            self.sut.getPlanets { result in
                XCTAssertTrue(Thread.isMainThread)
                switch result {
                    case .success(let response):
                        XCTAssertEqual(self.interactor.getPlanetsCallCount, 0)
                        XCTAssertEqual(response[0].name, responseObject.planets[0].name)
                        XCTAssertEqual(response[0].terrain, responseObject.planets[0].terrain)
                        XCTAssertEqual(response[0].url, responseObject.planets[0].url)
                    case .failure(let error):
                        XCTAssertNil(error)
                }
                
                exp.fulfill()
            }
        }
    }
    
}
