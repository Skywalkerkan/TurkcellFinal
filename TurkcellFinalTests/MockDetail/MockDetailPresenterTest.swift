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
        
        let expectation = self.expectation(description: "Loading should be shown and hidden correctly")
        
        presenter.didSelectSynonym("home")
        XCTAssertTrue(view.isInvokedShowLoading)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.view.isInvokedShowLoading)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                XCTAssertTrue(self.view.isInvokedHideLoading)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testFetchSynonymOutput() {
        XCTAssertFalse(view.isInvokedHideLoading)
        XCTAssertFalse(view.isInvokedShowLoading)
        XCTAssertEqual(presenter.allSynonyms?.count, 0)
        
        presenter.fetchOutputSynonms(.success(.response))
        XCTAssertFalse(view.isInvokedShowLoading)
        XCTAssertEqual(presenter.allSynonyms?.count, 5)

    }
    
    func testDeleteClicked() {
        
        let wordResult = [WordResult].response
        presenter.sourceDetail = wordResult
        
        presenter.deleteClicked()
        
        XCTAssertFalse(presenter.isFiltering)
        XCTAssertTrue(presenter.isItFirstTime)
        XCTAssertTrue(presenter.selectedCells.isEmpty)
        XCTAssertEqual(presenter.unselectedCells, ["noun", "verb", "adjective", "adverb", "noun"])
        XCTAssertEqual(presenter.filteredPartOfSpeech, ["X"])
    }
    
    func testPartOfSpeechDidSelect() {
        let wordResult = [WordResult].response
        presenter.sourceDetail = wordResult
        
        presenter.partOfSpeechDidSelect(selectedPhrase: "noun", indexPath: nil)
        
        XCTAssertTrue(presenter.isFiltering)
        XCTAssertEqual(presenter.selectedCells, ["noun"])
        XCTAssertFalse(presenter.unselectedCells.contains("noun"))
        XCTAssertEqual(presenter.filteredPartOfSpeech, ["X", "noun"])
    }


    
    func testSoundButton() {
        let wordResult = [WordResult].response
        presenter.sourceDetail = wordResult
        let url = presenter.soundButton()
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.absoluteString, "https://api.dictionaryapi.dev/media/pronunciations/en/home-us.mp3")
    }
    
    func testFetchWordOutput() {
        XCTAssertEqual(presenter.numberOfSection(), 0)
        let presenterSection = presenter.numberOfSection()
        XCTAssertEqual(presenter.numberOfRowsInSection(section: presenterSection), 0)

        presenter.fetchWordOutput(.success(.response))
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

