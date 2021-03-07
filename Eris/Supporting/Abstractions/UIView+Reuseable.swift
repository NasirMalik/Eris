//
//  Created by Nasir Mahmood on 07.03.21.
//

import Foundation
import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}

extension UITableViewCell: ReusableView {}

extension UITableViewHeaderFooterView: ReusableView {}

extension ReusableView where Self: UITableViewCell {
    static func register(in tableView: UITableView) {
        tableView.register(Self.self, forCellReuseIdentifier: Self.reuseIdentifier)
    }
    
}

extension ReusableView where Self: UITableViewHeaderFooterView {
    static func register(in tableView: UITableView) {
        tableView.register(self.self, forHeaderFooterViewReuseIdentifier: self.reuseIdentifier)
    }
    
}
