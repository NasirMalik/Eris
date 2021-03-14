//
//  Created by Nasir Mahmood on 28.02.21.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let persistorService: CoreDataService
    private let networkService: NetworkCheckService
    
    init(window: UIWindow,
         networkCheckService: NetworkCheckService,
         persistorService: CoreDataService) {
        self.window = window
        self.persistorService = persistorService
        self.networkService = networkCheckService
        navigationController = UINavigationController()
    }
    
    func start() {
        let viewController = UIViewControllerFactory.make(networkCheckService: networkService,
                                          persistorService: persistorService,
                                          completion: { [weak self] _ in
            self?.onComplete()
        })
        navigationController.viewControllers = [viewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    private func onComplete() {
        // TODO: Complete/Initiate Process here
    }
}
