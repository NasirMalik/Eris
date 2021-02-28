//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation
import UIKit
import Ceres

class PlanetsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var respository: PlanetsRepositoryImpl!
    var viewModel: PlanetsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizationConstants.pageTitle.rawValue
    
        let interactor = PlanetsInteractorImpl()
        respository = PlanetsRepositoryImpl(interactor: interactor)
        
        viewModel = PlanetsViewModelImpl(resository: respository)

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        respository.getPlanets { result in
            print(result)
        }
    }
}

extension PlanetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension PlanetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10//viewModel.planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetsTableViewCell") else {
            return UITableViewCell()
        }
        
        return cell
    }
    
}

private extension PlanetsViewController {
    
    enum LocalizationConstants: String {
        case pageTitle = "Planets"
    }
    
}

