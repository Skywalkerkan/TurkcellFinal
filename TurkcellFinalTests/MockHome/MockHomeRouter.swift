//
//  MockHomeRouter.swift
//  TurkcellFinalTests
//
//  Created by Erkan on 13.06.2024.
//

import Foundation
@testable import TurkcellFinal

final class MockHomeRouter: HomeRouterProtocol {
    
    func navigate(_ navigate: TurkcellFinal.HomeRoutes) {
        switch navigate {
        case .detail(let source):
            return
        }
    }
    
    
}
