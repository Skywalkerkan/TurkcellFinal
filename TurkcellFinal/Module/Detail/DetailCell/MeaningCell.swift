//
//  SynonymCell.swift
//  TurkcellFinal
//
//  Created by Erkan on 7.06.2024.
//

import UIKit

class MeaningCell: UICollectionViewCell {
    
    static let identifier = "MeaningCell"
    
    let meaningLabel: UILabel = {
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
        
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        
        contentView.addSubview(meaningLabel)
        NSLayoutConstraint.activate([
            meaningLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            meaningLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            meaningLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            meaningLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
