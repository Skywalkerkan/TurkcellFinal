//
//  InfoCell.swift
//  TurkcellFinal
//
//  Created by Erkan on 7.06.2024.
//

import UIKit

class InfoCell: UITableViewCell {

    static let identifier = "InfoCell"
    
    let partOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.text = "Labelcık"
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let definitionLabel: UILabel = {
        let label = UILabel()
        label.text = "Labelcık"
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let exampleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let exampleImageView: UIImageView = {
        let image = UIImage(systemName: "square.fill")?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.black)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        
    }
    
    private func setupViews(){
                
       // contentView.addSubview(partOfSpeechLabel)
        contentView.addSubview(definitionLabel)
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
           /* partOfSpeechLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            partOfSpeechLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            partOfSpeechLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            partOfSpeechLabel.heightAnchor.constraint(equalToConstant: 40),*/
            
            definitionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            definitionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            definitionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
           // definitionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            
          /* exampleLabel.topAnchor.constraint(equalTo: definitionLabel.bottomAnchor, constant: 8),
            exampleLabel.leadingAnchor.constraint(equalTo: definitionLabel.leadingAnchor, constant: 8),
            exampleLabel.trailingAnchor.constraint(equalTo: definitionLabel.trailingAnchor, constant: -8),
            
            exampleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)*/
            
            stackView.topAnchor.constraint(equalTo: definitionLabel.bottomAnchor, constant: 8),
              stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
              stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
              stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
        ])
        
        stackView.addArrangedSubview(exampleLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
