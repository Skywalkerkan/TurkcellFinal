//
//  DetailPresenter.swift
//  TurkcellFinal
//
//  Created by Erkan on 6.06.2024.
//

import Foundation

protocol DetailPresenterProtocol {
    func viewDidload(word: String?)
    func partOfSpeechDidSelect()
    var allSynonyms: [Synonym]? { get }
}

final class DetailPresenter {
    
    private var synonyms = [Synonym]()
   // private var selectedCells:
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
    
    
    func viewDidload(word: String?) {
        view.setupTableView()
        view.setupCollectionViews()
        interactor.fetchSynonms(word: word)
        view.reloadData()
    }
    
    func partOfSpeechDidSelect() {
        
    }
    
    var allSynonyms: [Synonym]? {
        return synonyms
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
