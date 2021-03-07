//
//  Created by Nasir Mahmood on 07.03.21.
//

import Foundation

protocol PlanetsViewModelMapper {
    func map(model: Planet) -> PlanetsViewData
}

struct PlanetsViewModelMapperImpl: PlanetsViewModelMapper {
    func map(model: Planet) -> PlanetsViewData {
        return .init(name: model.name?.uppercased() ?? "",
                     detail: model.terrain?.capitalized ?? "")
    }
    
}
