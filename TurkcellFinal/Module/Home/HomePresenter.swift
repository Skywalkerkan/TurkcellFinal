//
//  HomePresenter.swift
//  TurkcellFinal
//
//  Created by Erkan on 6.06.2024.
//

import Foundation


protocol HomePresenterProtocol {
    func viewDidLoad()
    func searchButtonClicked(word: String?)
    var fetchedSearches: [Search] { get }
    var fetchedWordInfo: [WordResult] { get }
    func didSelectRowAt(_ word: String?)
}

final class HomePresenter {
    
    private var searchs = [Search]()
    private var searchWord: String?
    private var wordResult = [WordResult]()
    unowned var view: HomeViewControllerProtocol
    let interactor: HomeInteractorProtocol
    let router: HomeRouterProtocol
    
    init(view: HomeViewControllerProtocol, interactor: HomeInteractorProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension HomePresenter: HomePresenterProtocol {
    
    func didSelectRowAt(_ word: String?) {
        view.showLoadingView()
        searchWord = word?.capitalizingFirstLetter()
        interactor.fetchWord(word: word)
    }
    
    var fetchedWordInfo: [WordResult] {
       /* DispatchQueue.main.async {
            self.interactor.saveWord(word: "hello")
        }*/
        return self.wordResult
    }
    
    
    func viewDidLoad() {
        view.setupTableView()
        view.setupSearchController()
        interactor.fetchSearchs()
        view.reloadData()
    }
    
    func searchButtonClicked(word: String?) {
        view.showLoadingView()
        searchWord = word?.capitalizingFirstLetter()
        interactor.fetchWord(word: word)
    }
    
    var fetchedSearches: [Search]{
        searchs
    }
    
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func fetchWordOutput(_ result: Result<[WordResult], NetworkError>) {
        switch result {
        case .success(let wordResults):
            self.wordResult = wordResults
            view.hideLoadingView()
            DispatchQueue.main.async {
                self.interactor.saveWord(word: self.searchWord)
                self.router.navigate(.detail(self.wordResult))
            }
        case .failure(let error):
            view.getError(error.localizedDescription)
            view.hideLoadingView()
        }
    }
    
    
    func fetchSearchOutput(_ searchs: [Search]) {
        self.searchs = searchs
        view.reloadData()
    }
    
    
}
