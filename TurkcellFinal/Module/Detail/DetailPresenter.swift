//
//  DetailPresenter.swift
//  TurkcellFinal
//
//  Created by Erkan on 6.06.2024.
//

import Foundation

protocol DetailPresenterProtocol {
    func viewDidload(word: String?, source: [WordResult]?)
    func partOfSpeechDidSelect(selectedPhrase: String?, indexPath: IndexPath?)
    var allSynonyms: [Synonym]? { get }

    //TOPCOLLECTİONVİEW
    func partOfSpeechCount() -> Int
    func partOfSpeech(index: Int) -> String
    func deleteClicked()
    func didSoundButtonClicked() -> URL?
    
    var isItFiltering: Bool { get }
    
    //TableView
    func numberOfSection() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(index: Int) -> Meaning?
}

final class DetailPresenter {
    
    private var filteredPartOfSpeech = ["X"]
    
    private var synonyms = [Synonym]()
    private var selectedCells = [String]()
    private var unselectedCells = [String]()
    private var isItFirstTime = true
    
    private var allPartOfSpeech = [Meaning]()
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
    
    func didSoundButtonClicked() -> URL? {
        if let phonetics = sourceDetail?.first?.phonetics{
            for phonetic in phonetics {
                
                if let audio = phonetic.audio, !audio.isEmpty, let url = URL(string: audio) {
                    return url
                }
            }
        }
        return nil
    }
    
    
    func deleteClicked() {
        isFiltering = false
        isItFirstTime = true
        selectedCells.removeAll()
        unselectedCells.removeAll()
        if let meanings = sourceDetail?.first?.meanings{
            for mean in meanings {
                if let partOfSpeech = mean.partOfSpeech {
                    unselectedCells.append(partOfSpeech)
                }
            }
        }
        filteredPartOfSpeech = ["X"]
        view.reloadData()
    }
    
    var isItFiltering: Bool{
        return isFiltering
    }
   
    
    func partOfSpeechCount() -> Int {
        if isFiltering {
            return filteredPartOfSpeech.count
        } else {
           return sourceDetail?.first?.meanings?.count ?? 0
        }
    }
    
    func partOfSpeech(index: Int) -> String {
        if isFiltering{
            return filteredPartOfSpeech[index]
        } else {
            return sourceDetail?.first?.meanings?[index].partOfSpeech ?? ""
        }
    }
    
    //TableView
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
        
        if let meanings = sourceDetail?.first?.meanings{
            for mean in meanings {
                if let partOfSpeech = mean.partOfSpeech {
                    unselectedCells.append(partOfSpeech)
                }
            }
        }
                
        view.reloadData()
    }

    func partOfSpeechDidSelect(selectedPhrase: String?, indexPath: IndexPath?) {
        
        if !selectedCells.contains(selectedPhrase ?? ""){
            selectedCells.append(selectedPhrase ?? "")
        }
        
        if !selectedCells.isEmpty {
            isFiltering = true
        }else{
            isFiltering = false
        }
        
        filterForWord(partOfSpeechList: selectedCells)
        
        //TODO: İNDEXPATHLERİ FORCELAMA
        
        for selected in selectedCells {
            if unselectedCells.contains(selected) {
                // selected öğesini unselectedCells'den kaldır
                unselectedCells.removeAll { $0 == selected }
            }
        }

            let joinedList = selectedCells.joined(separator: ", ")
            if isItFirstTime{
                filteredPartOfSpeech.append(joinedList)
                for unselectedCell in unselectedCells {
                    filteredPartOfSpeech.append(unselectedCell)
                }
            }else{
                filteredPartOfSpeech[1] = joinedList
                for selectedCell in selectedCells {
                    if selectedCell == selectedPhrase!{
                        filteredPartOfSpeech.removeAll { $0 == selectedCell }
                    }
                }
            }
        
        view.reloadData()
        isItFirstTime = false
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
