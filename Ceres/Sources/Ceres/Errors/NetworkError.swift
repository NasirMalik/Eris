//
//  Created by Nasir Mahmood on 27.02.21.
//

import Foundation

public enum NetworkError: Error {
    case parametersNil
    case serializationError
    case missingURL
    
    var localizedDescription: String {
        switch self {
            case .parametersNil: return "Parameters were nil."
            case .serializationError: return "Parameter serialization failed."
            case .missingURL: return "URL is nil."
        }
    }
}
