//
//  Created by Nasir Mahmood on 27.02.21.
//

import Foundation
import Ceres

enum PlanetsAPI {
    case getPlanets
}

extension PlanetsAPI: EndPointType {
    var baseURL: URL {
        URL(string: "https://swapi.dev/")!
    }

    var path: String {
        switch self {
        case .getPlanets:
            return "api/planets/"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getPlanets:
            return .get
        }
    }

    var task: HTTPTask {
        switch self {
        case .getPlanets:
            return .requestParameters(bodyParameters: nil, bodyEncoding: .jsonEncoding, urlParameters: [:])
        }
    }

    var headers: HTTPHeaders {
        switch self {
        case .getPlanets:
            return [:]
        }
    }
}
