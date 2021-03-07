//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation

protocol PlanetsRepository {
    typealias FetchCompletion = (Result<PlanetResponse, Error>) -> Void
    
    func getPlanets(_ completion: @escaping FetchCompletion)
    
}

struct PlanetsRepositoryImpl: PlanetsRepository {
    let interactor: PlanetsInteractor
    
    init(interactor: PlanetsInteractor) {
        self.interactor = interactor
    }
    
    func getPlanets(_ completion: @escaping FetchCompletion) {
        interactor.getPlanets(completion: { result in
            DispatchQueue.main.async {
                completion(result)
            }
        })
    }
    
}
