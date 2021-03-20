//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation
import Ceres

protocol PlanetsInteractor {
    typealias FetchCompletion = (Result<Response, Error>) -> Void
    
    func getPlanets(page: Int, completion: @escaping FetchCompletion)
}

struct PlanetsInteractorImpl: PlanetsInteractor {
    
    let service = NetworkServiceImpl<PlanetsAPI>()
    
    func getPlanets(page: Int, completion: @escaping FetchCompletion) {
        service.request(.getPlanets(page)) { result in
            completion(result)
        }
    }
    
}
