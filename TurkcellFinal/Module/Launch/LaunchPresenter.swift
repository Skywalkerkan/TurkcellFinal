//
//  LaunchPresenter.swift
//  TurkcellFinal
//
//  Created by Erkan on 4.06.2024.
//

import Foundation

protocol LaunchPresenterProtocol {
    func viewDidLoad()
}

final class LaunchPresenter {
    
    unowned var view: LaunchViewControllerProtocol
    let interactor: LaunchInteractorProtocol
    let router: LaunchRouterProtocol
    
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
    
}


