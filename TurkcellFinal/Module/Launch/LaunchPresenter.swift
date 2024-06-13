//
//  LaunchPresenter.swift
//  TurkcellFinal
//
//  Created by Erkan on 4.06.2024.
//

import Foundation

protocol LaunchPresenterProtocol {
    func viewDidLoad()
    func navigateToHome()
}

final class LaunchPresenter {
    
    unowned var view: LaunchViewControllerProtocol
    let interactor: LaunchInteractorProtocol
    let router: LaunchRouterProtocol
    
    let launchList = ["Understand the meanings of words and speak fluently with the dictionary in your hand", ""]
    
    init(view: LaunchViewControllerProtocol, interactor: LaunchInteractorProtocol, router: LaunchRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension LaunchPresenter: LaunchPresenterProtocol {
 
    func viewDidLoad() {
        view.setupCollectionView()
    }
    
    func navigateToHome() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.router.navigate(.home)
        }
    }
    
}


