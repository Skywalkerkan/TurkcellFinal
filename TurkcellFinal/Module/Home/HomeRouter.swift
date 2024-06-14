//
//  HomeRouter.swift
//  TurkcellFinal
//
//  Created by Erkan on 6.06.2024.
//

import Foundation

enum HomeRoutes {
    case detail(_ source: [WordResult]?)
}

protocol HomeRouterProtocol {
    func navigate(_ navigate: HomeRoutes)
}

final class HomeRouter {
    
    weak var viewController: HomeViewController?
    
    static func createModule() -> HomeViewController {
        let view = HomeViewController()
        let router = HomeRouter()
        let interactor = HomeInteractor()
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
    
}

extension HomeRouter: HomeRouterProtocol {
    
    func navigate(_ navigate: HomeRoutes) {
        
        switch navigate {
        case .detail(let source):
            DispatchQueue.main.async {
                let detailVC = DetailRouter.createModule()
                detailVC.source = source
                self.viewController?.navigationController?.pushViewController(detailVC, animated: true)
            }
        }

    }
}

