//
//  InfoCellPresenter.swift
//  TurkcellFinal
//
//  Created by Erkan on 11.06.2024.
//

import Foundation

protocol InfoCellPresenterProtocol {
    func load()
}

final class InfoCellPresenter {
    
    weak var view: InfoCellProtocol?
    private let definition: Definition
    private let index: String
    
    init(view: InfoCellProtocol?, definition: Definition, index: String) {
        self.view = view
        self.definition = definition
        self.index = index
    }
    
}

extension InfoCellPresenter: InfoCellPresenterProtocol {
    
    func load() {
        
        
        if let definition = definition.definition {
            let indexAndDefinition = index + definition
            view?.setDefinition(indexAndDefinition)
        }
        
        view?.setExample(definition.example)
        
        
                
       // view?.setTitleLabel(news.title ?? "")

    }
    
}
