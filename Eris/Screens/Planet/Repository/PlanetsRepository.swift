//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation
import Network

protocol PlanetsRepository {
    typealias FetchCompletion = (Result<[Planet], Error>) -> Void
    
    func getPlanets(_ completion: @escaping FetchCompletion)
    
}

final class PlanetsRepositoryImpl: PlanetsRepository {
    
    let interactor: PlanetsInteractor
    let persistor: CoreDataService
    var networkCheck: NetworkCheckService
    
    // TODO: initialize properly from networkCheck.currentStatus
    var networkAvailable: Bool = false
    
    init(interactor: PlanetsInteractor,
         persistor: CoreDataService,
         networkCheck: NetworkCheckService) {
        self.interactor = interactor
        self.persistor = persistor
        self.networkCheck = networkCheck
        
        networkCheck.addObserver(observer: self)
    }
    
    func getPlanets(_ completion: @escaping FetchCompletion) {
        if networkAvailable {
            interactorFetch(completion)
        } else {
            persistorFetch(completion)
        }
    }
    
    deinit {
        networkCheck.removeObserver(observer: self)
    }
    
}

private extension PlanetsRepositoryImpl {
    
    func persistorFetch(_ completion: @escaping FetchCompletion) {
        persistor.fetchPlanets { (result) in
            completion(result)
        }
    }
    
    func interactorFetch(_ completion: @escaping FetchCompletion) {
        interactor.getPlanets(completion: { result in
            switch result {
                case .success(let response):
                    try! self.persistor.savePlanets(planets: response.planets)
                    completion(.success(response.planets))
                case .failure(let error):
                    completion(.failure(error))
            }
        })
    }
    
}

extension PlanetsRepositoryImpl: NetworkCheckObserver {
    func statusDidChange(status: NWPath.Status) {
        if status == .satisfied {
            networkAvailable = true
        }else if status == .unsatisfied {
            networkAvailable = false
        }
    }
}
