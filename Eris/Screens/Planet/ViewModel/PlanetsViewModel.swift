//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation

protocol PlanetsViewModelDelegate: class {
    func reloadData(state: ViewControllerState)
}

protocol PlanetsViewModel {
    var planets: [Planet] { get }
    func loadData()
}

final class PlanetsViewModelImpl: PlanetsViewModel {
    
    typealias Completion = (Planet) -> Void
    
    let repository: PlanetsRepository
    let onCompletion: Completion

    weak var delegate: PlanetsViewModelDelegate?
    var planets = [Planet]()
    
    init(resository: PlanetsRepository,
         onCompletion: @escaping Completion) {
        self.repository = resository
        self.onCompletion = onCompletion
    }
    
    func loadData() {
        delegate?.reloadData(state: .loading)
        repository.getPlanets { [weak self] result in
            switch result {
                case .success(let response):
                    self?.planets.append(contentsOf: response)
                    self?.delegate?.reloadData(state: .success)
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.delegate?.reloadData(state: .error)
            }
        }
    }
}
