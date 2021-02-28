//
//  Created by Nasir Mahmood on 27.02.21.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    
    case requestParameters(
            bodyParameters: Parameters?,
            bodyEncoding: ParameterEncoding,
            urlParameters: Parameters?
         )
    
    case requestParametersAndHeaders(
            bodyParameters: Parameters?,
            bodyEncoding: ParameterEncoding,
            urlParameters: Parameters?,
            additionHeaders: HTTPHeaders?
         )
    
    // case download, upload...etc
}
