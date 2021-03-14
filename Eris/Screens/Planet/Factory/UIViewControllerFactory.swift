//
//  Created by Nasir Mahmood on 07.03.21.
//

import Foundation
import UIKit

struct UIViewControllerFactory {
    
    static func make(networkCheckService: NetworkCheckService,
                     persistorService: CoreDataService,
                     completion: @escaping (Planet) -> Void ) -> UIViewController {
        
        let interactor = PlanetsInteractorImpl()
        
        let respository = PlanetsRepositoryImpl(interactor: interactor,
                                                persistor: persistorService,
                                                networkCheck: networkCheckService)
        
        let viewModel = PlanetsViewModelImpl(resository: respository,
                                             onCompletion: completion)
        
        let viewController = PlanetsViewController.instantiate(from: .planets)
        viewController.viewModel = viewModel
        
        viewModel.delegate = viewController
        
        return viewController
    }
}


