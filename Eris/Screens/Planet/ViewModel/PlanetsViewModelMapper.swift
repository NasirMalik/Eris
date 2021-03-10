//
//  Created by Nasir Mahmood on 07.03.21.
//

import Foundation

protocol PlanetsViewModelMapper {
    func map(model: Planet) -> PlanetsViewData
}
 /*
 Planet is NSManagedObject thus optional here doesn't mean same as optional in swift, as per schema all properties are non-nullable and have default values thus can be safely force unwrapped.
 */
struct PlanetsViewModelMapperImpl: PlanetsViewModelMapper {
    func map(model: Planet) -> PlanetsViewData {
        return .init(name: model.name!,
                     rotationPeriod: model.rotationPeriod!,
                     orbitalPeriod: model.orbitalPeriod!,
                     diameter: model.diameter!,
                     climate: model.climate!,
                     gravity: model.gravity!,
                     terrain: model.terrain!,
                     surfaceWater: model.surfaceWater!,
                     created: model.created!,
                     edited: model.edited!,
                     url: model.url!)
    }
    
}
