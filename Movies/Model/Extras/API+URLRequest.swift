//
//  API+URLRequest.swift
//  Movies
//
//  Created by Juan Carlos on 19/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

extension API {
    
    static func urlRequest(_ url: String, httpMethod: HTTPMethod, parameters: [String: String]? = nil, token: String? = nil) -> URLRequest? {
        
        guard let urlToUse = URL(string: url) else { return nil }
        
        var urlRequest = URLRequest(url: urlToUse, cachePolicy:
            .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30.0)
        
        urlRequest.httpMethod = httpMethod.toString()
        
        if httpMethod == .post {
            urlRequest.httpBody = parameters?.percentEscaped().data(using: .utf8)
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if let tok = token {
            urlRequest.setValue("Bearer \(tok)", forHTTPHeaderField: "Authorization")
        }
        
        return urlRequest
    }
    
}
