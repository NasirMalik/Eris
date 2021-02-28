//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation

protocol PlanetsDelegate {
    func reloadData()
}

protocol PlanetsViewModel {
    var planets: [Planet] { get }
    func loadData()
}

struct PlanetsViewModelImpl: PlanetsViewModel {
    
    //let coordinator: AppCoordinator
    let repository: PlanetsRepository
    var delegate: PlanetsDelegate?
    
    var planets = [Planet]()
    
    init(resository: PlanetsRepository) {
        self.repository = resository
    }
    
    func loadData() {
        repository.getPlanets { result in
            switch result {
               case .success(let response):
                    print(response.planets)
               case .failure(let error):
                    print(error.localizedDescription)
               }
        }
    }
}
