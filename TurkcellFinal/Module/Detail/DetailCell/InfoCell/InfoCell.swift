//
//  InfoCell.swift
//  TurkcellFinal
//
//  Created by Erkan on 7.06.2024.
//

import UIKit

protocol InfoCellProtocol: AnyObject {
    func setDefinition(_ definition: String)
    func setExample(_ example: String?)
}

class InfoCell: UITableViewCell {

    static let identifier = "InfoCell"
    
    let partOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let definitionLabel: UILabel = {
        let label = UILabel()
        label.text = "Labelcık"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let exampleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let exampleImageView: UIImageView = {
        let image = UIImage(systemName: "square.fill")?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.black)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    var cellPresenter: InfoCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        
    }
    
    private func setupViews(){
                
        contentView.addSubview(definitionLabel)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            definitionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            definitionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            definitionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            stackView.topAnchor.constraint(equalTo: definitionLabel.bottomAnchor, constant: 4),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
        ])
        
        let exampleWrapper = UIView()
        exampleWrapper.addSubview(exampleLabel)
        NSLayoutConstraint.activate([
            exampleLabel.leadingAnchor.constraint(equalTo: exampleWrapper.leadingAnchor, constant: 8),
            exampleLabel.trailingAnchor.constraint(equalTo: exampleWrapper.trailingAnchor, constant: -8),
            exampleLabel.topAnchor.constraint(equalTo: exampleWrapper.topAnchor),
            exampleLabel.bottomAnchor.constraint(equalTo: exampleWrapper.bottomAnchor)
        ])
        stackView.addArrangedSubview(exampleWrapper)
        
        contentView.addSubview(exampleImageView)
        NSLayoutConstraint.activate([
            exampleImageView.topAnchor.constraint(equalTo: exampleLabel.topAnchor, constant: 4),
            exampleImageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 8),
            exampleImageView.heightAnchor.constraint(equalToConstant: 12),
            exampleImageView.widthAnchor.constraint(equalToConstant: 12)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension InfoCell: InfoCellProtocol {
    
    func setDefinition(_ definition: String) {
        
        definitionLabel.text = definition
        
    }
    
    func setExample(_ example: String?) {
        if let example = example {
            exampleLabel.text = "     " + example
            exampleImageView.isHidden = false
        }else{
            exampleImageView.isHidden = true
            exampleLabel.text = ""
        }
    }
    
}
