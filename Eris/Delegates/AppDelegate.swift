//
//  Created by Nasir Mahmood on 26.02.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordiantor: AppCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordiantor = AppCoordinator(window: window!,
                                        networkCheckService: NetworkCheckService(),
                                        persistorService: CoreDataService())
        appCoordiantor.start()
        
        return true
    }
}

