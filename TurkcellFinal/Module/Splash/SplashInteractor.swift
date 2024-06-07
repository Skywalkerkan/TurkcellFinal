//
//  SplashInteractor.swift
//  TurkcellFinal
//
//  Created by Erkan on 30.05.2024.
//

import Foundation

protocol SplashInteractorProtocol{
    func checkInternetConnection()
}

protocol SplashInteractorOutputProtocol{
    func checkInternetStatus(status: Bool)
}

final class SplashInteractor{
    var output: SplashInteractorOutputProtocol?
}

extension SplashInteractor: SplashInteractorProtocol{
    func checkInternetConnection() {
        let internetStatus = API.shared.isConnectedToInternet()
        self.output?.checkInternetStatus(status: internetStatus)
    }
}
