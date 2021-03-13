//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation
import UIKit
import Ceres

enum ViewControllerState {
    case loading
    case error
    case success
}

final class PlanetsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    var viewModel: PlanetsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizationConstants.pageTitle.rawValue
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
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
        
        let viewData = viewModel.planets[indexPath.row]
        cell.configure(with: viewData)
        
        return cell
    }
    
}

extension PlanetsViewController: PlanetsViewModelDelegate {
    func reloadData(state: ViewControllerState) {
        switch state {
            case .loading:
                self.activity.startAnimating()
            case .error:
                self.activity.stopAnimating()
            case .success:
                self.activity.stopAnimating()
                self.tableView.reloadData()
        }
    }
}

