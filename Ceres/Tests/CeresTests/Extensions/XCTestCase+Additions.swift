//
//  Created by Nasir Mahmood on 09.03.21.
//

import Foundation
import XCTest

extension XCTestCase {
    
    func expectation(timeout: TimeInterval = 1.0, handler: @escaping (XCTestExpectation) -> Void) {
        let expectation = XCTestExpectation(description: "com.eris.ceris.expectation")
        handler(expectation)
        wait(for: [expectation], timeout: timeout)
    }
    
}
