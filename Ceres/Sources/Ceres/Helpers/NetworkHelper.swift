//
//  Created by Nasir Mahmood on 27.02.21.
//

import Foundation

struct NetworkHelper {
    static let shared = NetworkHelper()
    private init() {}
    
    func handle<T: Decodable>(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ResultWithError<T> {
        var result: ResultWithError<T> = .failure(NetworkResponseError.failed)
        if let error = error {
            result = .failure(error)
            return result
        }
        
        guard let response = response as? HTTPURLResponse else {
            result = .failure(NetworkResponseError.httpURLResponseCastFailed)
            return result
        }
        switch handleNetworkResponse(response) {
            case .success:
                guard let responseData = data else {
                    result = .failure(NetworkResponseError.noData)
                    return result
                }
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                    print(jsonData)
                    let apiResponse = try JSONDecoder().decode(T.self, from: responseData)
                    result = .success(apiResponse)
                } catch {
                    print(error)
                    result = .failure(NetworkResponseError.unableToDecode)
                }
            case .failure(let networkFailureError):
                result = .failure(networkFailureError)
        }
        return result
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> ResultWithError<Void> {
        switch response.statusCode {
            case 200...299: return .success(())
            case 401...500: return .failure(NetworkResponseError.authenticationError)
            case 501...599: return .failure(NetworkResponseError.badRequest)
            case 600: return .failure(NetworkResponseError.outdated)
            default: return .failure(NetworkResponseError.failed)
        }
    }
}

