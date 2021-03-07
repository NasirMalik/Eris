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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetsTableViewCell") else {
            return UITableViewCell()
        }
        
        return cell
    }
    
}

extension PlanetsViewController: PlanetsViewModelDelegate {
    
    func reloadData() {
        activity.stopAnimating()
        tableView.reloadData()
    }
}

