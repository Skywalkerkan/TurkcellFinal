//
//  SplashInteractor.swift
//  TurkcellFinal
//
//  Created by Erkan on 30.05.2024.
//

import Foundation

protocol SplashInteractorProtocol{
    func checkInternetConnection()
    func firstTimeLaunch()
}

protocol SplashInteractorOutputProtocol{
    func checkInternetStatus(status: Bool)
    func launchedBefore(status: Bool)
}

final class SplashInteractor{
    var output: SplashInteractorOutputProtocol?
}

extension SplashInteractor: SplashInteractorProtocol{
    func checkInternetConnection() {
        let internetStatus = API.shared.isConnectedToInternet()
        self.output?.checkInternetStatus(status: internetStatus)
    }
    
    func firstTimeLaunch() {
        let defaults = UserDefaults.standard
        
        if defaults.bool(forKey: "hasLaunchedBefore") {
            self.output?.launchedBefore(status: true)
        } else {
            self.output?.launchedBefore(status: false)
            defaults.set(true, forKey: "hasLaunchedBefore")
            defaults.synchronize()
        }
    }
}
