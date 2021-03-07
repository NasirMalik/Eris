//
//  Created by Nasir Mahmood on 28.02.21.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    let window: UIWindow
    let navigationController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
    }
    
    func start() {
        let viewController = PlanetsViewController.make(completion: { [weak self] _ in
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
