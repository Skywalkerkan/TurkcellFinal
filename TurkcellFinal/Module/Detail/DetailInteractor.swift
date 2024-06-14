//
//  DetailInteractor.swift
//  TurkcellFinal
//
//  Created by Erkan on 6.06.2024.
//

import Foundation

private let networkService: WordsServiceProtocol = API()

protocol DetailInteractorProtocol {
    func fetchSynonyms(word: String?, completion: @escaping () -> Void)
    func fetchWord(word: String, completion: @escaping () -> Void)
}

protocol DetailInteractorOutputProtocol {
    func fetchOutputSynonms(_ result: Result<[Synonym], NetworkError>)
    func fetchWordOutput(_ result: Result<[WordResult], NetworkError>)

}

final class DetailInteractor {
    var output: DetailInteractorOutputProtocol?
}

extension DetailInteractor: DetailInteractorProtocol {
    
    func fetchWord(word: String, completion: @escaping () -> Void) {
        networkService.fetchWord(baseUrl: .word, word: word) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchWordOutput(result)
            completion()
        }
    }
    
    func fetchSynonyms(word: String?, completion: @escaping () -> Void) {
        networkService.fetchSynonms(baseUrl: .synonyms, word: word) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchOutputSynonms(result)
            completion()
        }
    }
}
