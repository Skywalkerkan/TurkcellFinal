//
//  MockHomeViewController.swift
//  TurkcellFinalTests
//
//  Created by Erkan on 13.06.2024.
//

import Foundation
@testable import TurkcellFinal

final class MockViewController: HomeViewControllerProtocol {
    func reloadData() {
        
    }
    
    var isInvokedShowLoading = false
    var invokedShowLoadingCount = 0
    
    func showLoadingView() {
        isInvokedShowLoading = true
        invokedShowLoadingCount += 1
    }
    
    var isInvokedHideLoading = false
    var invokedHideLoadingCount = 0
    
    func hideLoadingView() {
        isInvokedHideLoading = true
        invokedHideLoadingCount += 1
    }
    
    func setupTableView() {
        
    }

    func setupSearchController() {
        
    }
    
    func getError(_ errorString: String) {
        
    }
    
    var invokedSetTitle = false
    var invokedSetTitleCount = 0
    var invokedSetTitleParamters: (title: String, Void)?
    
    func setTitle(_ title: String) {
        invokedSetTitle = true
        invokedSetTitleCount += 1
        invokedSetTitleParamters = (title, ())
    }
    
    
}

