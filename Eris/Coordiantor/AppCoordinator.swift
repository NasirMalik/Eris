//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation
import UIKit

protocol AppCoordinator {
    var navigationController: UINavigationController { get }
    func start()
}
