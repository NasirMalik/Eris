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
    private var refreshControl: UIRefreshControl!
    var viewModel:  PlanetsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        setupTableView()
        title = LocalizationConstants.pageTitle.rawValue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.loadData()
    }
}

extension PlanetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.shouldShowLoadingCell ? viewModel.planets.count + 1 : viewModel.planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.isLoadingIndexPath(indexPath),
           let loadingCell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.reuseIdentifier) {
            return loadingCell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PlanetsTableViewCell.reuseIdentifier) as? PlanetsTableViewCell else {
                assertionFailure("Should not fall through")
                return UITableViewCell()
            }
            
            let viewData = viewModel.planets[indexPath.row]
            cell.configure(with: viewData)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteRow(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

extension PlanetsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard viewModel.isLoadingIndexPath(indexPath) else { return }
        viewModel.loadData()
    }
    
}

extension PlanetsViewController: PlanetsViewModelDelegate {
    func reloadData(state: ViewControllerState) {
        switch state {
            case .loading:
                refreshControl.beginRefreshing()
            case .error:
                // TODO: Error handling UI
                refreshControl.endRefreshing()
            case .success:
                refreshControl.endRefreshing()
                self.tableView.reloadData()
        }
    }
}

private extension PlanetsViewController {
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.loadData()
    }
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: LocalizationConstants.refreshTitle.rawValue)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
    }
}
