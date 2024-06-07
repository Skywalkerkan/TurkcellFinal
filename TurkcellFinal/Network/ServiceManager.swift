//
//  ServiceManager.swift
//  TurkcellFinal
//
//  Created by Erkan on 6.06.2024.
//

import Foundation

protocol WordsServiceProtocol {
    func fetchWord(baseUrl: BaseUrl, word: String?, completion: @escaping(Result<[WordResult], NetworkError>) -> Void)
    func fetchSynonms(baseUrl: BaseUrl, word: String?, completion: @escaping(Result<[Synonym], NetworkError>) -> Void)
}

extension API: WordsServiceProtocol {
    
    func fetchWord(baseUrl: BaseUrl, word: String?, completion: @escaping (Result<[WordResult], NetworkError>) -> Void) {
        exequteRequestFor(baseUrl: baseUrl.rawValue, word: word, completion: completion)
    }
    
    func fetchSynonms(baseUrl: BaseUrl, word: String?, completion: @escaping(Result<[Synonym], NetworkError>) -> Void) {
        exequteRequestFor(baseUrl: baseUrl.rawValue, word: word, completion: completion)
    }
    
}
