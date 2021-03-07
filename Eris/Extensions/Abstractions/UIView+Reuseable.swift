//
//  Created by Nasir Mahmood on 07.03.21.
//

import Foundation
import UIKit

public protocol ReusableView {
    static var reuseIdentifier: String { get }
}

public extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}

extension UITableViewCell: ReusableView {}

extension UITableViewHeaderFooterView: ReusableView {}

public extension ReusableView where Self: UITableViewCell {
    static func register(in tableView: UITableView) {
        tableView.register(Self.self, forCellReuseIdentifier: Self.reuseIdentifier)
    }
    
}

public extension ReusableView where Self: UITableViewHeaderFooterView {
    static func register(in tableView: UITableView) {
        tableView.register(self.self, forHeaderFooterViewReuseIdentifier: self.reuseIdentifier)
    }
    
}
