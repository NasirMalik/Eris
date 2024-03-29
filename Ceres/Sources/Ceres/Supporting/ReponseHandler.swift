//
//  Created by Nasir Mahmood on 27.02.21.
//

import Foundation

struct ReponseHandler {
    
    static func handle<Model: Decodable>(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ResultWithError<Model> {
    
        if let error = error {
            return .failure(error)
        }
        
        guard let response = response as? HTTPURLResponse else {
            return .failure(NetworkResponseError.httpURLResponseCastFailed)
        }
        
        switch handleResponseStatus(response) {
            case .success:
                guard let responseData = data else {
                    return .failure(NetworkResponseError.noData)
                }
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                    print(jsonData)
                    let apiResponse = try JSONDecoder.defaultDecoder.decode(Model.self, from: responseData)
                    return .success(apiResponse)
                } catch(let error) {
                    print(error)
                    return .failure(NetworkResponseError.unableToDecode)
                }
            case .failure(let networkFailureError):
                return .failure(networkFailureError)
        }
        
    }
    
}

private extension ReponseHandler {
    
    static func handleResponseStatus(_ response: HTTPURLResponse) -> ResultWithError<Void> {
        switch response.statusCode {
            case 200...299: return .success(())
            case 401...500: return .failure(NetworkResponseError.authenticationError)
            case 501...599: return .failure(NetworkResponseError.badRequest)
            case 600: return .failure(NetworkResponseError.outdated)
            default: return .failure(NetworkResponseError.failed)
        }
    }
    
}

extension JSONDecoder {
    
    static var defaultDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
