//
//  LaunchRouter.swift
//  TurkcellFinal
//
//  Created by Erkan on 4.06.2024.
//

import Foundation
import UIKit

enum LaunchRoutes{
    case home
}

protocol LaunchRouterProtocol {
    func navigate(_ route: LaunchRoutes)

}

final class LaunchRouter {
    
    weak var viewController: LaunchViewController?
    
    static func createModule() -> LaunchViewController {
        
        let view = LaunchViewController()
        let interactor = LaunchInteractor()
        let router = LaunchRouter()
        let presenter = LaunchPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        router.viewController = view
        return view
    }
    
}

extension LaunchRouter: LaunchRouterProtocol {

    func navigate(_ route: LaunchRoutes) {
        switch route{
        case .home:
            guard let window = viewController?.view.window else { return }
            let homeVC = HomeRouter.createModule()
            let navigationController = UINavigationController(rootViewController: homeVC)
            window.rootViewController = navigationController
        }
    }
    
}
