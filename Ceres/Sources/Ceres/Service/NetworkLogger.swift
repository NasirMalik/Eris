//
//  Created by Nasir Mahmood on 27.02.21.
//

import Foundation

final class NetworkLogger {
    
    static func log(request: URLRequest) {
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print(" - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)

        let method = request.httpMethod ?? ""
        let path = urlComponents?.path ?? ""
        let query = urlComponents?.query ?? ""
        let host = urlComponents?.host ?? ""

        var logOutput = """
                        \(urlAsString) \n
                        \(method) \(path)?\(query) HTTP/1.1 \n
                        HOST: \(host)\n
                        """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        print(logOutput)
    }

    static func log(response: URLResponse?) {}
}
