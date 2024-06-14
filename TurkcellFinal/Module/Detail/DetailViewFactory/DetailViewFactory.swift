//
//  HeaderViewFactory.swift
//  TurkcellFinal
//
//  Created by Erkan on 12.06.2024.
//

import UIKit

class DetailInfoFactoryView {
        
    func createScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }

    func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    func createTopView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(red: 242/255, green: 241/255, blue: 246/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    func createWordLabel() -> UILabel {
        let label = UILabel()
        label.text = "Home"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    func createPronounceLabel() -> UILabel {
        let label = UILabel()
        label.text = "homesa"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    func createSoundButton(target: Any?, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 20
        button.applyShadow()
        let image = UIImage(systemName: "person.wave.2")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.addTarget(target, action: action, for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return button
    }
    
    func createMeaningsCollectionView() -> UICollectionView {
           let layout = UICollectionViewFlowLayout()
           layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
           layout.scrollDirection = .horizontal
           let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           collectionView.showsHorizontalScrollIndicator = false
           collectionView.backgroundColor = .clear
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           return collectionView
       }
       
       func createTableView() -> SelfSizingTableView {
           let tableView = SelfSizingTableView()
           tableView.backgroundColor = .systemGray6
           tableView.layer.cornerRadius = 20
           tableView.sectionHeaderTopPadding = 12
           tableView.separatorStyle = .none
           tableView.allowsSelection = false
           tableView.clipsToBounds = true
           tableView.translatesAutoresizingMaskIntoConstraints = false
           return tableView
       }
       
       func createSynonymLabel() -> UILabel {
           let label = UILabel()
           label.textColor = .black
           label.textAlignment = .left
           label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
           label.text = "Synonyms"
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }
    
        func createNoSynonymLabel() -> UILabel {
            let label = UILabel()
            label.textColor = .black
            label.textAlignment = .left
            label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            label.text = "No Synonyms Found"
            label.isHidden = true
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }
       
       func createSynonymCollectionView() -> UICollectionView {
           let layout = UICollectionViewFlowLayout()
           layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
           layout.scrollDirection = .horizontal
           let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           collectionView.backgroundColor = .clear
           collectionView.showsHorizontalScrollIndicator = false
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           return collectionView
       }

    func createFooterView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    static func createHeaderView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
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
