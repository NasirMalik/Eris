//
//  Created by Nasir Mahmood on 10.03.21.
//

import Foundation

extension JSONDecoder {
    
    static var defaultDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}

extension String {

    func modelByDecodingJSON<T: Decodable>() throws -> T {
        let encodedString = data(using: .utf8)!
        return try JSONDecoder.defaultDecoder.decode(T.self, from: encodedString)
    }

}
