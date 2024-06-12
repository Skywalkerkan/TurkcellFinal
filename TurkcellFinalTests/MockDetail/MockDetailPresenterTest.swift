//
//  MockHomePresenterTest.swift
//  TurkcellFinalTests
//
//  Created by Erkan on 13.06.2024.
//

import XCTest
@testable import TurkcellFinal

final class DetailPresenterTests: XCTestCase {
    
    var presenter: DetailPresenter!
    var view: MockDetailViewController!
    var interactor: MockDetailInteractor!
    var router: MockDetailRouter!

    override func setUp() {
        super.setUp()
        
        view = .init()
        interactor = .init()
        router = .init()
        
        presenter = .init(view: view, interactor: interactor, router: router)
    }

    override func tearDown() {
        super.tearDown()
        
        view = nil
        interactor = nil
        router = nil
        presenter = nil
    }
    
   func testDidSelectSynonym() {
       
       XCTAssertFalse(view.isInvokedHideLoading)
       XCTAssertFalse(view.isInvokedShowLoading)
       presenter.didSelectSynonym("home")
       XCTAssertTrue(view.isInvokedShowLoading)
       XCTAssertFalse(view.isInvokedHideLoading)

    }
    
    func testFetchSynonymOutput() {
        XCTAssertFalse(view.isInvokedHideLoading)
        XCTAssertFalse(view.isInvokedShowLoading)
        XCTAssertEqual(presenter.allSynonyms?.count, 0)
        
        presenter.fetchOutputSynonms(.success(.response))
        XCTAssertFalse(view.isInvokedShowLoading)
        XCTAssertEqual(presenter.allSynonyms?.count, 5)

    }
    
    func testFetchWordOutput() {
        XCTAssertFalse(view.isInvokedHideLoading)
        XCTAssertFalse(view.isInvokedShowLoading)
        XCTAssertEqual(presenter.numberOfSection(), 0)
        let presenterSection = presenter.numberOfSection()
        XCTAssertEqual(presenter.numberOfRowsInSection(section: presenterSection), 0)

        presenter.fetchWordOutput(.success(.response))
        XCTAssertTrue(view.isInvokedHideLoading)
        XCTAssertFalse(view.isInvokedShowLoading)
        XCTAssertEqual(presenter.numberOfSection(), 5)
        XCTAssertEqual(presenter.numberOfRowsInSection(section: presenterSection), 4)

    }
    

}

extension [Synonym] {
    
    static var response: [Synonym] {
        let bundle = Bundle(for: DetailPresenterTests.self)
        let path = bundle.path(forResource: "SynonymMock", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let response = try! JSONDecoder().decode([Synonym].self, from: data)
        return response
    }
    
}

