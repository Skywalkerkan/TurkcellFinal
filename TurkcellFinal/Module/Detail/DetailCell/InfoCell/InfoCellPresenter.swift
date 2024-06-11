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
    
    init(view: InfoCellProtocol?, definition: Definition) {
        self.view = view
        self.definition = definition
    }
    
}

extension InfoCellPresenter: InfoCellPresenterProtocol {
    
    func load() {
        
        
        if let definition = definition.definition {
            view?.setDefinition(definition)
        }
        
        view?.setExample(definition.example)
        
        
                
       // view?.setTitleLabel(news.title ?? "")

    }
    
}
