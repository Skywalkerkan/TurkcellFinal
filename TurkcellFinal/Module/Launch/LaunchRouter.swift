//
//  LaunchRouter.swift
//  TurkcellFinal
//
//  Created by Erkan on 4.06.2024.
//

import Foundation

protocol LaunchRouterProtocol {
    
}

final class LaunchRouter {
    
    weak var viewController: LaunchViewController?
    
    static func createModule() -> LaunchViewController {
        
        let view = LaunchViewController()
        let interactor = LaunchInteractor()
        let router = LaunchRouter()
        let presenter = LaunchPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        //interactor.out
        router.viewController = view
        return view
    }
    
}

extension LaunchRouter: LaunchRouterProtocol {
    
}
