//
//  DetailPresenter.swift
//  TurkcellFinal
//
//  Created by Erkan on 6.06.2024.
//

import Foundation

protocol DetailPresenterProtocol {
    func viewDidload(word: String?)
    func partOfSpeechDidSelect(source: [WordResult]?)
    var allSynonyms: [Synonym]? { get }
    
    func numberOfSection(source: [WordResult]?) -> Int
    func numberOfRowsInSection(source: [WordResult]?, section: Int) -> Int

  //  func cellForRowAt(index: Int) -> Meaning?
    
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
    
    func numberOfRowsInSection(source: [WordResult]?, section: Int) -> Int {
        // source?.first?.meanings?[section].definitions?.count ?? 0
        if let definitionsCount = source?.first?.meanings?[section].definitions?.count {
            return definitionsCount
        } else {
            return 0
        }
    }
    
    
    func numberOfSection(source: [WordResult]?) -> Int {
        if let meaningCount = source?.first?.meanings?.count {
            return meaningCount
        } else {
            return 0
        }
        
    }
    
    /*func cellForRowAt(index: Int) -> Meaning? {
        return Meaning(from: <#any Decoder#>)
    }*/
    
    
    func viewDidload(word: String?) {
        view.setupTableView()
        view.setupCollectionViews()
        interactor.fetchSynonms(word: word)
       // view.reloadData()
    }
    
    func partOfSpeechDidSelect(source: [WordResult]?) {
        print(source?.first?.meanings?.count)
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
            view.reloadData()
        case .failure(let error):
            print("hata alıyom")
        }
    }
    
    
}
