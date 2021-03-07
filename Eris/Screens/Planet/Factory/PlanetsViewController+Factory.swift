//
//  Created by Nasir Mahmood on 07.03.21.
//

import Foundation
import UIKit

extension PlanetsViewController {
    static func make(completion: @escaping (Planet) -> Void ) -> UIViewController {
        
        let interactor = PlanetsInteractorImpl()
        let persistor = CoreDataService.shared
        let networkCheck = NetworkCheckService.shared
        
        let respository = PlanetsRepositoryImpl(interactor: interactor,
                                                persistor: persistor,
                                                networkCheck: networkCheck)
        
        let mapper = PlanetsViewModelMapperImpl()
        let viewModel = PlanetsViewModelImpl(resository: respository,
                                             onCompletion: completion)
        
        let viewController = PlanetsViewController.instantiate(from: .planets)
        
        viewModel.delegate = viewController

        viewController.viewModel = viewModel
        viewController.mapper = mapper
        
        return viewController
    }
}


