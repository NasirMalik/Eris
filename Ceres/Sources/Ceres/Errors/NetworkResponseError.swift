//
//  Created by Nasir Mahmood on 27.02.21.
//

import Foundation

public enum NetworkResponseError: Error {
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
    case httpURLResponseCastFailed
    
    var localizedDescription: String {
        switch self {
        case .authenticationError: return "You need to be authenticated first."
        case .badRequest: return "Bad request."
        case .outdated: return "The url you requested is outdated."
        case .failed: return "Network request failed."
        case .noData: return "Response returned with no data to decode."
        case .unableToDecode: return "We could not decode the response."
        case .httpURLResponseCastFailed: return "HTTP url response cast failed."
        }
    }
}
