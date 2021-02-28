//
//  Created by Nasir Mahmood on 28.02.21.
//

import Foundation
import UIKit

struct AppCoordinator: Coordinator {
    
    let window: UIWindow
    let navigationController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Planets", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "PlanetsViewController")
        navigationController.viewControllers = [viewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    
}
