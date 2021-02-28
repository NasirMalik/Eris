//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation
import UIKit
import Ceres

class PlanetsViewController: UIViewController {
    
    var respository: PlanetsRepositoryImpl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let interactor = PlanetsInteractorImpl()
        respository = PlanetsRepositoryImpl(interactor: interactor)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        respository.getPlanets { result in
            print(result)
        }
    }
}

