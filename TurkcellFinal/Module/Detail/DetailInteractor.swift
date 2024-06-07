//
//  DetailInteractor.swift
//  TurkcellFinal
//
//  Created by Erkan on 6.06.2024.
//

import Foundation

private let networkService: WordsServiceProtocol = API()

protocol DetailInteractorProtocol {
    func fetchSynonms(word: String?)
}


protocol DetailInteractorOutputProtocol {
    func fetchOutputSynonms(_ result: Result<[Synonym], NetworkError>)
}


final class DetailInteractor {
    var output: DetailInteractorOutputProtocol?
}

extension DetailInteractor: DetailInteractorProtocol {
    func fetchSynonms(word: String?) {
        networkService.fetchSynonms(baseUrl: .synonyms, word: word) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchOutputSynonms(result)
        }
    }
}
