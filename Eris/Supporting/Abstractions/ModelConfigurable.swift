//
//  Created by Nasir Mahmood on 07.03.21.
//

import Foundation
/*
    All views, which needs to be populated from a model should be ModelConfigurable
 */

protocol ModelConfigurable {
    associatedtype Model
    
    func configure(with model: Model)
}
