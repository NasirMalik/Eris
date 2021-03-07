//
//  Created by Nasir Mahmood on 07.03.21.
//

import Foundation
import UIKit

extension PlanetsViewController {
    
    static func make(coordinator: AppCoordinator) -> UIViewController {
        let interactor = PlanetsInteractorImpl()
        let respository = PlanetsRepositoryImpl(interactor: interactor)
        let viewModel = PlanetsViewModelImpl(coordinator:coordinator,
                                             resository: respository)
        
        let viewController = PlanetsViewController.instantiateFrom(storyboardName: .planets)
        
        viewController.viewModel = viewModel
        viewModel.delegate = viewController
        return viewController
    }
    
}


