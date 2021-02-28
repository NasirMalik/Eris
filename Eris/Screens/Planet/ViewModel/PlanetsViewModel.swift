//
//  Created by Nasir Mahmood on 26.02.21.
//

import Foundation

protocol PlanetsViewModel {
    var planets: [Planet] { get }
    
    func loadData()
}

struct PlanetsViewModelImpl: PlanetsViewModel {
    var planets: [Planet]
    
    func loadData() {}
}
