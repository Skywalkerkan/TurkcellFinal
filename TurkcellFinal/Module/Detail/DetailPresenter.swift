//
//  DetailPresenter.swift
//  TurkcellFinal
//
//  Created by Erkan on 6.06.2024.
//

import Foundation

protocol DetailPresenterProtocol {
    func viewDidload(word: String?)
    var allSynonyms: [Synonym]? { get }
}

final class DetailPresenter {
    
    private var synonyms = [Synonym]()
    
    unowned var view: DetailViewControllerProtocol
    let interactor: DetailInteractorProtocol
    let router: DetailRouter
    
    init(view: DetailViewControllerProtocol, interactor: DetailInteractorProtocol, router: DetailRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension DetailPresenter: DetailPresenterProtocol {
    
    var allSynonyms: [Synonym]? {
        return synonyms
    }
    
    func viewDidload(word: String?) {
        view.setupTableView()
        interactor.fetchSynonms(word: word)
    }
    
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    
    func fetchOutputSynonms(_ result: Result<[Synonym], NetworkError>) {
        switch result {
        case .success(let synonyms):
            self.synonyms = synonyms
            print("okey")
            print(self.synonyms)
           // view.reloadData()
        case .failure(let error):
            print("hata alıyom")
        }
    }
    
    
}
