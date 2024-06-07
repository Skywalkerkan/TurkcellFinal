//
//  DetailPresenter.swift
//  TurkcellFinal
//
//  Created by Erkan on 6.06.2024.
//

import Foundation

protocol DetailPresenterProtocol {
    func viewDidload(word: String?, source: [WordResult]?)
    func partOfSpeechDidSelect(selectedPhrase: String?)
    var allSynonyms: [Synonym]? { get }
    func numberOfSection() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(index: Int) -> Meaning?
    
}

final class DetailPresenter {
    
    private var synonyms = [Synonym]()
    private var selectedCells = [String]()
    private var isFiltering = false
    private var sourceDetail: [WordResult]?
    private var filteredSourceDetail: [WordResult]?

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

    
    func numberOfRowsInSection(section: Int) -> Int {
        // source?.first?.meanings?[section].definitions?.count ?? 0
        if isFiltering {
            if let definitionsCount = filteredSourceDetail?.first?.meanings?[section].definitions?.count {
                return definitionsCount
            } else {
                return 0
            }
        }else {
            if let definitionsCount = sourceDetail?.first?.meanings?[section].definitions?.count {
                return definitionsCount
            } else {
                return 0
            }
        }

    }
    
    
    func numberOfSection() -> Int {
        if isFiltering {
            if let meaningCount = filteredSourceDetail?.first?.meanings?.count {
                return meaningCount
            } else {
                return 0
            }
        } else {
            if let meaningCount = sourceDetail?.first?.meanings?.count {
                return meaningCount
            } else {
                return 0
            }
        }

        
    }
    
    func cellForRowAt(index: Int) -> Meaning? {
        
        if isFiltering{
            if let meaning = filteredSourceDetail?.first?.meanings?[index]{
                return meaning
            }else{
                return nil
            }
        } else {
            if let meaning = sourceDetail?.first?.meanings?[index]{
                return meaning
            }else{
                return nil
            }
        }
    }

    
    func viewDidload(word: String?, source: [WordResult]?) {
        view.setupTableView()
        view.setupCollectionViews()
        interactor.fetchSynonms(word: word)
        self.sourceDetail = source
       // view.reloadData()
    }

    func partOfSpeechDidSelect(selectedPhrase: String?) {
        
        if !selectedCells.contains(selectedPhrase ?? ""){
            selectedCells.append(selectedPhrase ?? "")
        }
        
        if !selectedCells.isEmpty {
            isFiltering = true
        }else{
            isFiltering = false
        }
        
        filterForWord(partOfSpeechList: selectedCells)
        view.reloadData()
        
    }
    
    func filterForWord(partOfSpeechList: [String]) {
        guard !partOfSpeechList.isEmpty, let sourceDetail = sourceDetail else {
            return
        }

        let filteredResults = sourceDetail.map { wordResult -> WordResult in
            var updatedWordResult = wordResult
            updatedWordResult.meanings = wordResult.meanings?.filter { partOfSpeechList.contains($0.partOfSpeech ?? "") }
            return updatedWordResult
        }

        filteredSourceDetail = filteredResults
        print("ok")
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
            view.reloadData()
        case .failure(let error):
            print("hata alıyom")
        }
    }
    
    
}
