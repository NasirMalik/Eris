//
//  Created by Nasir Mahmood on 13.03.21.
//
import Foundation
import XCTest
@testable import Eris

final class PlanetsInteractorMock: PlanetsInteractor {
    
    typealias FetchCompletion = (Result<Response, Error>) -> Void
    
    var getPlanetsCallCount = 0
    var getPlanetsCompletionClosure: FetchCompletion?
    var result: Result<Response, Error>?
    
    func getPlanets(completion: @escaping FetchCompletion) {
        getPlanetsCallCount += 1
        getPlanetsCompletionClosure = completion
        
        if let result = result {
            completion(result)
        }
    }
}

