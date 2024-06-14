//
//  MockInteractor.swift
//  TurkcellFinalTests
//
//  Created by Erkan on 13.06.2024.
//

import Foundation
@testable import TurkcellFinal

final class MockDetailInteractor: DetailInteractorProtocol {

    let dispatchGroup = DispatchGroup()

    var isInvokedFetchSynonms = false
    var invokedFetchSynonmsCount = 0

    func fetchSynonyms(word: String?, completion: @escaping () -> Void) {
        isInvokedFetchSynonms = true
        invokedFetchSynonmsCount += 1
        dispatchGroup.enter()
        DispatchQueue.global().async {
            completion()
            self.dispatchGroup.leave()
        }
    }

    var isInvokedFetchWord = false
    var invokedFetchWordsCount = 0

    func fetchWord(word: String, completion: @escaping () -> Void) {
        isInvokedFetchWord = true
        invokedFetchWordsCount += 1
        dispatchGroup.enter()
        DispatchQueue.global().async {
            completion()
            self.dispatchGroup.leave()
        }
    }

}

