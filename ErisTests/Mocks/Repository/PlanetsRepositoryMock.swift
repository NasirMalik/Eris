//
//  Created by Nasir Mahmood on 10.03.21.
//

import Foundation
import XCTest
@testable import Eris

final class PlanetsRepositoryMock: PlanetsRepository {
        
    typealias FetchCompletion = (Result<[Planet], Error>) -> Void
    
    var count: Int = Int(INT_MAX)
    var getPlanetsCallCount = 0
    var getPlanetsCompletionClosure: FetchCompletion?
    var result: Result<[Planet], Error>?
    var getPageNumber = 0
    
    func getPlanets(page: Int, completion: @escaping FetchCompletion) {
        getPlanetsCallCount += 1
        getPlanetsCompletionClosure = completion
        getPageNumber = page
        
        if let result = result {
            count = try! result.get().count
            completion(result)
        }
    }
}
