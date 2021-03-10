//
//  Created by Nasir Mahmood on 08.03.21.
//

import Foundation

final class URLSessionMock: URLSession {
    
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    var data: Data?
    var error: Error?
    var statusCode: Int?
    
    override func dataTask(with request: URLRequest, completionHandler: CompletionHandler?) -> URLSessionDataTask {
        
        let data = self.data
        let error = self.error
        var response: HTTPURLResponse? = nil
        
        if let code = statusCode {
            response = HTTPURLResponse(url: request.url!, statusCode: code, httpVersion: nil, headerFields: nil)
        }
        
        return URLSessionDataTaskMock.init {
            completionHandler?(data, response, error)
        }
    }
}
