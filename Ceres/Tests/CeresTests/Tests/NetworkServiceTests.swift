import Foundation
import XCTest
@testable import Ceres

final class NetworkServiceTests: XCTestCase {
    
    var session: URLSessionMock!
    var sut: NetworkServiceImpl<MockAPI>!
    
    override func setUp() {
        super.setUp()
        
        session = URLSessionMock()
        sut = NetworkServiceImpl<MockAPI>(session: session)
    }
    
    func testNetwork_Success() {
        
        session.statusCode = 200
        session.data = StubModel.modelData()
        
        expectation { exp in
            self.sut.request(.getPlanets) { (result: Result<MockResponse, Error>) in
                switch result {
                    case .success(let response):
                        XCTAssertEqual(response, StubModel.modelObject())
                    case .failure(let error):
                        XCTAssertNil(error)
                }
                
                exp.fulfill()
            }
        }
    }
    
    func testNetwork_Failure() {
        session.statusCode = nil
        session.data = nil
        
        expectation { exp in
            self.sut.request(.getPlanets) { (result: Result<MockResponse, Error>) in
                switch result {
                    case .success(let response):
                        XCTAssertNil(response)
                    case .failure(let error):
                        XCTAssertNotNil(error)
                }
                
                exp.fulfill()
            }
        }
    }

    static var allTests = [
        ("testNetwork_Success", testNetwork_Success),
        ("testNetwork_Failure", testNetwork_Failure)
    ]
}
