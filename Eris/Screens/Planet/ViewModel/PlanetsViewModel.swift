//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation

protocol PlanetsViewModelDelegate: class {
    func reloadData(state: ViewControllerState)
}

protocol PlanetsViewModel {
    var shouldShowLoadingCell: Bool { get }
    var planets: [PlanetViewData] { get }
    
    func loadData()
    func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool
}

final class PlanetsViewModelImpl: PlanetsViewModel {
    
    typealias Completion = (Planet) -> Void
    
    private let repository: PlanetsRepository
    private let onCompletion: Completion

    weak var delegate: PlanetsViewModelDelegate?
    
    var shouldShowLoadingCell: Bool = false
    var planets = [PlanetViewData]()
    var currentPage = 1
    
    init(resository: PlanetsRepository,
         onCompletion: @escaping Completion) {
        self.repository = resository
        self.onCompletion = onCompletion
    }
    
    func loadData() {
        delegate?.reloadData(state: .loading)
        repository.getPlanets(page: currentPage) { [weak self] result in
            switch result {
                case .success(let response):
                    self?.parse(response)
                    self?.delegate?.reloadData(state: .success)
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.shouldShowLoadingCell = false
                    self?.delegate?.reloadData(state: .error)
            }
        }
    
    }
    
    func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        guard shouldShowLoadingCell else { return false }
        return indexPath.row == planets.count
    }
}

// MARK: Mapping
private extension PlanetsViewModelImpl {
    
    func parse(_ response: [Planet]) {
        let viewDataObjects = makeViewData(planets: response)
        viewDataObjects.forEach {
            if !planets.contains($0) {
                planets.append($0)
            }
        }
        
        currentPage += 1
        shouldShowLoadingCell = planets.count < repository.count
    }
    
    func makeViewData(planets: [Planet]) -> [PlanetViewData] {
        var viewDatas = [PlanetViewData]()
        planets.forEach {
            if let viewData = map(model: $0) {
                viewDatas.append(viewData)
            }
        }
        return viewDatas
    }
    
    func map(model: Planet) -> PlanetViewData? {
        
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
