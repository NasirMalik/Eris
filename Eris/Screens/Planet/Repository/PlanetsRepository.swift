//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation
import Network

protocol PlanetsRepository {
    typealias FetchCompletion = (Result<[Planet], Error>) -> Void
    var count: Int { get }
    
    func getPlanets(page: Int, completion: @escaping FetchCompletion)
}

final class PlanetsRepositoryImpl: PlanetsRepository {
    
    private let interactor: PlanetsInteractor
    private let persistor: CoreDataService
    private let networkCheck: NetworkCheckService
    
    var count = Int.max
    var networkAvailable: Bool!
    
    init(interactor: PlanetsInteractor,
         persistor: CoreDataService,
         networkCheck: NetworkCheckService) {
        self.interactor = interactor
        self.persistor = persistor
        self.networkCheck = networkCheck
        
        networkCheck.addObserver(observer: self)
        networkAvailable = networkCheck.currentStatus == .satisfied
    }
    
    func getPlanets(page: Int, completion: @escaping FetchCompletion) {
        if networkAvailable {
            interactorFetch(page: page, completion: completion)
        } else {
            persistorFetch(page: page, completion: completion)
        }
    }
    
    deinit {
        networkCheck.removeObserver(observer: self)
    }
    
}

private extension PlanetsRepositoryImpl {
    
    func persistorFetch(page: Int, completion: @escaping FetchCompletion) {
        
        count = persistor.getRecordsCount()
        persistor.fetchPlanets(page: page) { result in
            completion(result)
        }
    }
    
    func interactorFetch(page: Int, completion: @escaping FetchCompletion) {
        interactor.getPlanets(page: page, completion: { [weak self] result in
            switch result {
                case .success(let response):
                    do {
                        self?.count = response.count
                        try self?.persistor.savePlanets(page: page, planets: response.planets)
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
