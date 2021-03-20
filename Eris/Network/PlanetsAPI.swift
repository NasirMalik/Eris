//
//  Created by Nasir Mahmood on 27.02.21.
//

import Foundation
import Ceres

enum PlanetsAPI {
    case getPlanets(Int)
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
        case .getPlanets(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["page": page])
        }
    }

    var headers: HTTPHeaders {
        switch self {
        case .getPlanets:
            return [:]
        }
    }
}
