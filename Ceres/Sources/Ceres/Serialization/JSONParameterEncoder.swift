//
//  Created by Nasir Mahmood on 28.02.21.
//

import Foundation

struct JSONParameterEncoder: ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            
            guard urlRequest.value(forHTTPHeaderField: "ContentType") == nil else { return }
            urlRequest.setValue("application/json", forHTTPHeaderField: "ContentType")
        } catch {
            throw NetworkError.serializationError
        }
    }
}
