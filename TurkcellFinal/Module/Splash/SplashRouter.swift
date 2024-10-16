//
//  SplashRouter.swift
//  TurkcellFinal
//
//  Created by Erkan on 30.05.2024.
//

import Foundation
import UIKit

enum SplashRoutes{
    case launch
    case home
}

protocol SplashRouterProtocol{
    func navigate(_ route: SplashRoutes)
}

final class SplashRouter{
    weak var viewController: SplashViewController?
    
    
    static func createModule() -> SplashViewController{
        let view = SplashViewController()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        let presenter = SplashPresenter(view: view, router: router, interactor: interactor)
        view.presesenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

extension SplashRouter: SplashRouterProtocol{
    
    func navigate(_ route: SplashRoutes) {
        switch route{
            
        case .launch:
            guard let window = viewController?.view.window else { return }
            let launchVC = LaunchRouter.createModule()
            window.rootViewController = launchVC
            
        case .home:
            guard let window = viewController?.view.window else { return }
            let homeVC = HomeRouter.createModule()
            let navigationController = UINavigationController(rootViewController: homeVC)
            window.rootViewController = navigationController
        }
    }
}
