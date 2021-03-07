//
//  Created by Nasir Mahmood on 27.02.21.
//

import Foundation

public typealias ResultWithError<Model> = Result<Model, Error>
public typealias NetworkServiceCompletion<Model: Decodable> = (ResultWithError<Model>) -> Void

public protocol NetworkService: AnyObject {
    associatedtype EndPoint: EndPointType
    
    func request<Model: Decodable>(_ route: EndPoint, completion: @escaping NetworkServiceCompletion<Model>)
}

public final class NetworkServiceImpl<EndPoint: EndPointType>: NetworkService {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request<Model: Decodable>(_ route: EndPoint, completion: @escaping NetworkServiceCompletion<Model>) {
        
        do {
            let request = try buildRequest(from: route)
            let task = session.dataTask(with: request) { data, response, error in
                completion(ReponseHandler.handle(data, response, error))
            }
            
            task.resume()
            
        } catch {
            completion(.failure(error))
        }
    }
    
}

private extension NetworkServiceImpl {
    
    func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(
            url: route.baseURL.appendingPathComponent(route.path),
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 10.0
        )
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.task {
                case .request:
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                case .requestParameters(let bodyParameters, let bodyEncoding, let urlParameters):
                    try configureParameters(bodyParameters: bodyParameters, bodyEncoding: bodyEncoding, urlParameters: urlParameters, request: &request)
                case .requestParametersAndHeaders(let bodyParameters, let bodyEncoding, let urlParameters, let additionalHeaders):
                    addAdditionalHeaders(additionalHeaders, request: &request)
                    try configureParameters(bodyParameters: bodyParameters, bodyEncoding: bodyEncoding, urlParameters: urlParameters, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    func configureParameters(bodyParameters: Parameters?, bodyEncoding: ParameterEncoding, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request, bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}

