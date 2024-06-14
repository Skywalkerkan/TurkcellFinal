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
    //let interactor: LaunchInteractorProtocol
    let router: LaunchRouterProtocol
    
    let launchList = ["Understand the meanings of words and speak fluently with the dictionary in your hand", "Find the words you want and look at their meanings, learn word types easily"]
    let animations = ["animation1", "animation2"]
    
    init(view: LaunchViewControllerProtocol, router: LaunchRouterProtocol) {
        self.view = view
        self.router = router
    }
    
}

extension LaunchPresenter: LaunchPresenterProtocol {
 
    func viewDidLoad() {
        view.setupCollectionView()
    }
    
    func navigateToHome() {
        DispatchQueue.main.async {
            self.router.navigate(.home)
        }
    }
    
}


