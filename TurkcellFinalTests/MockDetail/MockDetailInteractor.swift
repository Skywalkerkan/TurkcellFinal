//
//  MockInteractor.swift
//  TurkcellFinalTests
//
//  Created by Erkan on 13.06.2024.
//

import Foundation
@testable import TurkcellFinal

final class MockDetailInteractor: DetailInteractorProtocol {
    
    var isInvokedFetchSynonms = false
    var invokedFetchSynonmsCount = 0
    
    func fetchSynonms(word: String?) {
        isInvokedFetchSynonms = true
        invokedFetchSynonmsCount += 1
    }
    
    var isInvokedFetchWord = false
    var invokedFetchWordsCount = 0
    
    func fetchWord(word: String) {
        isInvokedFetchWord = true
        invokedFetchWordsCount += 1
    }
}

