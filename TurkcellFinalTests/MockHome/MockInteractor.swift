//
//  MockInteractor.swift
//  TurkcellFinalTests
//
//  Created by Erkan on 13.06.2024.
//

import Foundation
@testable import TurkcellFinal

final class MockInteractor: HomeInteractorProtocol {

    
    
    var isInvokedFetchNews = false
    var invokedFetchNewsCount = 0
    
    func fetchNews() {
        isInvokedFetchNews = true
        invokedFetchNewsCount += 1
    }
    
    var isInvokedFetchSearchs = false
    var invokedFetchSearchCounts = 0
    
    func fetchSearchs() {
        isInvokedFetchSearchs = true
        invokedFetchSearchCounts += 1
    }
    
    var isInvokedFetchWord = false
    var invokedFetchWordCount = 0
    
    func fetchWord(word: String?) {
        isInvokedFetchWord = true
        invokedFetchWordCount += 1
    }
    
    var isInvokedSaveWord = false
    var invokedSaveWord = 0
    
    func saveWord(word: String?) {
        isInvokedSaveWord = true
        invokedSaveWord += 1
    }
        
    func deleteWord(word: String?) {
        
    }
    
}

