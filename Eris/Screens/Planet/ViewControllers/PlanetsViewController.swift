//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation
import UIKit
import Ceres

final class PlanetsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    var viewModel: PlanetsViewModel!
    var mapper: PlanetsViewModelMapper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizationConstants.pageTitle.rawValue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        activity.startAnimating()
        viewModel.loadData()
    }
}

extension PlanetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlanetsTableViewCell.reuseIdentifier) as? PlanetsTableViewCell else {
            return UITableViewCell()
        }
        
        let planet = viewModel.planets[indexPath.row]
        // TODO: move data mapping to viewModel
        let viewData = mapper.map(model: planet)
        cell.configure(with: viewData)
        
        return cell
    }
    
}

extension PlanetsViewController: PlanetsViewModelDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.activity.stopAnimating()
            self.tableView.reloadData()
        }
    }
}

