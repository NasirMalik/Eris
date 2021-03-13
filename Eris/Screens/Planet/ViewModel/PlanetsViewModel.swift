//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation

protocol PlanetsViewModelDelegate: class {
    func reloadData(state: ViewControllerState)
}

protocol PlanetsViewModel {
    var planets: [PlanetsViewData] { get }
    func loadData()
}

final class PlanetsViewModelImpl: PlanetsViewModel {
    
    typealias Completion = (Planet) -> Void
    
    private let repository: PlanetsRepository
    private let onCompletion: Completion

    weak var delegate: PlanetsViewModelDelegate?
    
    var planets = [PlanetsViewData]()
    
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
                    // TODO: Handle duplicate data case
                    self?.planets.append(contentsOf: self?.makeViewData(planets: response) ?? [])
                    self?.delegate?.reloadData(state: .success)
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.delegate?.reloadData(state: .error)
            }
        }
    
    }
}

// MARK: Mapping
private extension PlanetsViewModelImpl {
    
    func makeViewData(planets: [Planet]) -> [PlanetsViewData] {
        var viewDatas = [PlanetsViewData]()
        planets.forEach {
            if let viewData = map(model: $0) {
                viewDatas.append(viewData)
            }
        }
        return viewDatas
    }
    
    func map(model: Planet) -> PlanetsViewData? {
        
        guard let name = model.name else {
            return nil
        }
        
        guard let terrain = model.terrain else {
            return nil
        }
        
        return .init(name: name.uppercased(),
                     terrain: terrain.capitalized)
    }
    
}
