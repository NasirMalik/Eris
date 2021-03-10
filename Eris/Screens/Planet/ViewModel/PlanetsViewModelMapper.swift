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
        return .init(name: model.name!.uppercased(),
                     rotationPeriod: model.rotationPeriod!.capitalized,
                     orbitalPeriod: model.orbitalPeriod!.capitalized,
                     diameter: model.diameter!.capitalized,
                     climate: model.climate!.capitalized,
                     gravity: model.gravity!.capitalized,
                     terrain: model.terrain!.capitalized,
                     surfaceWater: model.surfaceWater!.capitalized,
                     created: model.created!.capitalized,
                     edited: model.edited!.capitalized,
                     url: model.url!.capitalized)
    }
    
}
