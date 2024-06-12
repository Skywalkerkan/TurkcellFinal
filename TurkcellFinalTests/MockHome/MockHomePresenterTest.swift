//
//  MockHomePresenterTest.swift
//  TurkcellFinalTests
//
//  Created by Erkan on 13.06.2024.
//

import XCTest
@testable import TurkcellFinal

final class HomePresenterTests: XCTestCase {
    
    
    var presenter: HomePresenter!
    var view: MockHomeViewController!
    var interactor: MockHomeInteractor!
    var router: MockHomeRouter!
    

    override func setUp() {
        super.setUp()
        
        view = .init()
        interactor = .init()
        router = .init()
        
        presenter = .init(
            view: view,
            interactor: interactor,
            router: router
        )
    }

    override func tearDown() {
        super.tearDown()
        
        view = nil
        interactor = nil
        router = nil
        presenter = nil
    }
    
    func testSearchButtonClickedAndFetchWord() {
        XCTAssertFalse(view.isInvokedHideLoading)
        XCTAssertFalse(view.isInvokedShowLoading)

        presenter.searchButtonClicked(word: "home")
        XCTAssertTrue(view.isInvokedShowLoading)
    }
    
    func testFetchWordOutput() {
        XCTAssertFalse(view.isInvokedHideLoading)
        XCTAssertFalse(view.isInvokedShowLoading)

        presenter.fetchWordOutput(.success(.response))
        XCTAssertFalse(view.isInvokedShowLoading)
        XCTAssertTrue(view.isInvokedHideLoading)
    }

}

extension [WordResult] {
    
    static var response: [WordResult] {
        let bundle = Bundle(for: HomePresenterTests.self)
        let path = bundle.path(forResource: "WordMock", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let response = try! JSONDecoder().decode([WordResult].self, from: data)
        return response
    }
    
}

