//
//  HttpRequestHandler.swift
//  PlanetList
//
//  Created by Amila Prasad on 2022-09-11.
//

import Foundation
import Network

protocol HttpRequestHandlerProtocol {
    func request(endPoint: String,
                 onSuccess: @escaping(Data?) -> Void,
                 onFailure: @escaping(String) -> Void)
}

final class HttpRequestHandler : HttpRequestHandlerProtocol {
    
    func request(endPoint: String,
                 onSuccess: @escaping(Data?) -> Void,
                 onFailure: @escaping(String) -> Void)
    {
        var request = URLRequest(url: URL(string: endPoint)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, urlResponse, error) in
            if let data = data {
                onSuccess(data)
            } else if let error = error {
                onFailure("HTTP Request Failed \(error.localizedDescription)")
            }
        }).resume()
    }
}
