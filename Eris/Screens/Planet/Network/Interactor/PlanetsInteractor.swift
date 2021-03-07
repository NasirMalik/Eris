//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation
import Ceres

protocol PlanetsInteractor {
    
    typealias FetchCompletion = (Result<PlanetResponse, Error>) -> Void
    
    func getPlanets(completion: @escaping FetchCompletion)
}

struct PlanetsInteractorImpl: PlanetsInteractor {
    
    let service = NetworkServiceImpl<PlanetsAPI>()
    
    func getPlanets(completion: @escaping FetchCompletion) {
        service.request(.getPlanets) { result in
            completion(result)
        }
    }
    
}
