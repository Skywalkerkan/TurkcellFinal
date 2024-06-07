//
//  SplashPresenter.swift
//  TurkcellFinal
//
//  Created by Erkan on 30.05.2024.
//

import Foundation

protocol SplashPresenterProtocol{
    func viewDidAppear()
}

final class SplashPresenter: SplashPresenterProtocol{
    
    unowned var view: SplashViewControllerProtocol!
    let router: SplashRouter!
    let interactor: SplashInteractor!
    
    init(view: SplashViewControllerProtocol, router: SplashRouter, interactor: SplashInteractor) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidAppear() {
        interactor.checkInternetConnection()
    }
}

extension SplashPresenter: SplashInteractorOutputProtocol{
    func checkInternetStatus(status: Bool) {
        if status{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
               // self.router.navigate(.home)
                self.router.navigate(.home)
            }
        }
    }
}
