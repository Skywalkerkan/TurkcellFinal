//
//  HeaderViewFactory.swift
//  TurkcellFinal
//
//  Created by Erkan on 12.06.2024.
//

import UIKit

class DetailInfoFactoryView {
    
    static func createHeaderView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }

    static func createPartOfSpeechLabel() -> UILabel {
        let label = UILabel()
        label.text = "ok"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor(red: 247/255, green: 150/255, blue: 71/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    static func createImageView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(systemName: "arrowtriangle.right.fill")?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.black))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    static func setupConstraints(for view: UIView, imageView: UIImageView, label: UILabel) {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            imageView.heightAnchor.constraint(equalToConstant: 15),
            imageView.widthAnchor.constraint(equalToConstant: 12),
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
        ])
    }
    
    static func createFooterView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }

}
