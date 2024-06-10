//
//  InfoCellPresenter.swift
//  TurkcellFinal
//
//  Created by Erkan on 11.06.2024.
//

import Foundation
import UIKit
/*

protocol InfoCellPresenterProtocol {
    func load()
}

final class InfoCellPresenter {
    
    weak var view: NewsCellProtocol?
    private let news: News
    
    init(
        view: NewsCellProtocol?,
        news: News
    ) {
        self.view = view
        self.news = news
    }
    
}

extension InfoCellPresenter: InfoCellPresenterProtocol {
    
    func load() {
        
        ImageDownloader.shared.image(news: news, format: .threeByTwoSmallAt2X) { [weak self] data, error in
            guard let self else { return }
            if let data {
                guard let image = UIImage(data: data) else { return }
                self.view?.setImage(image)
            }
        }
                
        view?.setTitleLabel(news.title ?? "")
        view?.setAuthorLabel(news.byline ?? "")
    }
    
}
*/
