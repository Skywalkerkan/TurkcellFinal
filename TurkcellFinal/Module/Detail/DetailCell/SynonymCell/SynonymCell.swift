//
//  SynonymCell.swift
//  TurkcellFinal
//
//  Created by Erkan on 7.06.2024.
//

import UIKit

class SynonymCell: UICollectionViewCell {
    
    static let identifier = "SynonymCell"
    
    let synonymLabel: UILabel = {
        let label = UILabel()
        label.text = "Labelcık"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    private func setupViews(){
        
        contentView.layer.cornerRadius = 4
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        
        contentView.addSubview(synonymLabel)
        NSLayoutConstraint.activate([
            synonymLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            synonymLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            synonymLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            synonymLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
