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
    var getPageNumber = 0
    
    func getPlanets(page: Int, completion: @escaping FetchCompletion) {
        getPlanetsCallCount += 1
        getPageNumber = page
        getPlanetsCompletionClosure = completion
        
        if let result = result {
            completion(result)
        }
    }
}

