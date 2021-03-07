//
//  Created by Nasir Mahmood on 07.03.21.
//

import Foundation

public protocol ModelConfigurable {
    associatedtype Model
    
    func configure(with model: Model)
}
