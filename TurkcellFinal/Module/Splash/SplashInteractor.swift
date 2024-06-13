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
        
        // Check if the app has been launched before
        if defaults.bool(forKey: "hasLaunchedBefore") {
            print("App has been launched before")
            // Not the first launch
            self.output?.launchedBefore(status: true)
        } else {
            print("This is the first launch")
            self.output?.launchedBefore(status: false)
            defaults.set(true, forKey: "hasLaunchedBefore")
            defaults.synchronize()
        }
    }
}
