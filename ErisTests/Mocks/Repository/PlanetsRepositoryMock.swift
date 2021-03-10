//
//  Created by Nasir Mahmood on 10.03.21.
//

import Foundation
import XCTest
@testable import Eris

final class PlanetsRepositoryMock: PlanetsRepository {
    
    typealias FetchCompletion = (Result<[Planet], Error>) -> Void
    
    var getPlanetsCallCount = 0
    var getPlanetsCompletionClosure: FetchCompletion?
    var result: Result<[Planet], Error>?
    
    func getPlanets(_ completion: @escaping FetchCompletion) {
        getPlanetsCallCount += 1
        getPlanetsCompletionClosure = completion
        
        if let result = result {
            completion(result)
        }
    }
}
