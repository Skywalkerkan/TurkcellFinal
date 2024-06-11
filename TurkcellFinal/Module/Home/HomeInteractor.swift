//
//  HomeInteractor.swift
//  TurkcellFinal
//
//  Created by Erkan on 6.06.2024.
//

import Foundation


private let networkService: WordsServiceProtocol = API()

protocol HomeInteractorProtocol {
    func fetchSearchs()
    func fetchWord(word: String?)
    func saveWord(word: String?)
    func deleteWord(word: String?)
}

protocol HomeInteractorOutputProtocol {
    func fetchSearchOutput(_ searchs: [Search])
    func fetchWordOutput(_ result: Result<[WordResult], NetworkError>)

}

final class HomeInteractor {
    var output: HomeInteractorOutputProtocol?
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func deleteWord(word: String?) {
        let searchRepository = SearchRepository()
        searchRepository.deleteSameSearch(search: Search(searchString: word))
        print("Silindi")
    }
    
    func saveWord(word: String?) {
        deleteWord(word: word)
        let searchRepository = SearchRepository()
        searchRepository.saveSearch(search: Search(searchString: word))
        print("kaydedildi")
    }
    
    
    func fetchSearchs() {
        let searchRepository = SearchRepository()
        let searchs = searchRepository.fetchSearchedWords() ?? [Search]()
        self.output?.fetchSearchOutput(searchs)
    }
    
    func fetchWord(word: String?) {
        networkService.fetchWord(baseUrl: .word ,word: word) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchWordOutput(result)
        }
    }
    
}
