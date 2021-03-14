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
    
    private let interactor: PlanetsInteractor
    private let persistor: CoreDataService
    private var networkCheck: NetworkCheckService
    
    var networkAvailable: Bool?
    
    init(interactor: PlanetsInteractor,
         persistor: CoreDataService,
         networkCheck: NetworkCheckService) {
        self.interactor = interactor
        self.persistor = persistor
        self.networkCheck = networkCheck
        
        networkCheck.addObserver(observer: self)
    }
    
    func getPlanets(_ completion: @escaping FetchCompletion) {
        if let internetPresent = networkAvailable,
           internetPresent == true {
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
                    do {
                        try self.persistor.savePlanets(planets: response.planets)
                        completion(.success(response.planets))
                    } catch(let error) {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        })
    }
    
}
/*
 Due to bug in Simulator API, NWPath.Status will never return .satisfied while testing on simulator,
 If network was turned off and then turned on.
 */
extension PlanetsRepositoryImpl: NetworkCheckObserver {
    func statusDidChange(status: NWPath.Status) {
        if status == .satisfied {
            networkAvailable = true
        }else if status == .unsatisfied {
            networkAvailable = false
        }
    }
}
