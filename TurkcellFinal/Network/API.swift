//
//  API.swift
//  TurkcellFinal
//
//  Created by Erkan on 30.05.2024.
//

import Foundation


enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

enum BaseUrl: String {
    case word = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    case synonyms = "https://api.datamuse.com/words?rel_syn="
}



final class API {
    
    static let shared: API = {
        let instance = API()
        return instance
    }()
    
    
    var baseURL = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    
    private var service: NetworkService
    
    init(service: NetworkService = NetworkManager()) {
        self.service = service
    }
}

extension API {
    
    func isConnectedToInternet() -> Bool {
        Reachability.isConnectedToNetwork()
    }
    
    func prepareURLRequestFor(
        word: String?,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        method: RequestMethod = .get
    ) -> URLRequest? {
        
        var urlString = ""
        if let wordString = word{
            urlString = baseURL + wordString
        }
        guard let url = URL(string: urlString) else { return nil }
        
        var request = URLRequest(url: url)
        
        if let params = parameters {
            
            if method == .get {
                guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                    return nil
                }
                
                let queryItems = params.map {
                    URLQueryItem(name: $0.key, value: String(describing: $0.value))
                }
                
                urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
                
                guard let newUrl = urlComponents.url else { return nil }
                
                request = URLRequest(url: newUrl)
            } else {
                let jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                request.httpBody = jsonData
            }
        }
        
        
        request.httpMethod = method.rawValue
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let requestHeaders = headers {
            for (field, value) in requestHeaders {
                request.setValue(value, forHTTPHeaderField: field)
            }
        }
                
        return request
    }
    
    func exequteRequestFor<T: Decodable> (
        baseUrl: String,
        word: String?,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        method: RequestMethod = .get,
        completion: @escaping(Result<T, NetworkError>) -> Void
    ) {
        
        if var urlRequest = prepareURLRequestFor(
                word: word,
                parameters: parameters,
                headers: headers,
                method: method
            ) {
            let fullUrlString = baseUrl + (word ?? "")
            
            if let url = URL(string: fullUrlString) {
                urlRequest.url = url
                service.performRequest(urlRequest: urlRequest, completion: completion)
            } else {
                completion(.failure(.invalidRequest))
            }
        } else {
            completion(.failure(.invalidRequest))
        }
        
    }
}
