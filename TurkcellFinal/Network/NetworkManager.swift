//
//  NetworkManager.swift
//  TurkcellFinal
//
//  Created by Erkan on 30.05.2024.
//

import Foundation

enum NetworkError: Error{
    
    case invalidRequest
    case requestFailed
    case jsonDecodedError
    case customError(Error)
    
    var localizedDescription: String{
        switch self{
        case .invalidRequest:
            return "Invalid Request"
        case .requestFailed:
            return "Request Failed, please check your internet connection and try again"
        case .jsonDecodedError:
            return "Failed to json data"
        case .customError(let error):
            return error.localizedDescription
        }
    }
}
    //TODO: BUNU DÜZENLE SONRA AYAR ÇEK

protocol NetworkService {
    func performRequest<T: Decodable>(
        urlRequest: URLRequest,
        completion: @escaping(Result<T, NetworkError>) -> Void
    )
}

final class NetworkManager {
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
}

extension NetworkManager: NetworkService {
    
    func performRequest<T>(urlRequest: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
            if let error {
                completion(.failure(.customError(error)))
            } else if let data {
                do {
                    let responseObj = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(responseObj))
                } catch {
                    completion(.failure(.jsonDecodedError))
                }
            } else {
                completion(.failure(.requestFailed))
            }
        }
        
        task.resume()
    }
    
    
}

