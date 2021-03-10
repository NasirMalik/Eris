//
//  Created by Nasir Mahmood on 08.03.21.
//

import Foundation
import Ceres

enum MockAPI {
    case getPlanets
}

extension MockAPI: EndPointType {
    var baseURL: URL {
        URL(string: "https://google.com/")!
    }

    var path: String {
        switch self {
        case .getPlanets:
            return "api/images/"
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
