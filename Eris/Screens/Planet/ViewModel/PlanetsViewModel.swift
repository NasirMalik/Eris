//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation

protocol PlanetsViewModelDelegate {
    func reloadData()
}

protocol PlanetsViewModel {
    var planets: [Planet] { get }
    func loadData()
}

final class PlanetsViewModelImpl: PlanetsViewModel {
    
    let coordinator: AppCoordinator
    let repository: PlanetsRepository
    var delegate: PlanetsViewModelDelegate?
    
    var planets = [Planet]()
    
    init(coordinator: AppCoordinator,
         resository: PlanetsRepository) {
        self.coordinator = coordinator
        self.repository = resository
    }
    
    func loadData() {
        repository.getPlanets { [weak self] result in
            switch result {
                case .success(let response):
                    self?.planets.append(contentsOf: response.planets)
                case .failure(let error):
                    print(error.localizedDescription)
            }
            
            self?.delegate?.reloadData()
            
        }
    }
}
