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
        
        contentView.layer.cornerRadius = 18
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.shadowColor = UIColor.darkGray.cgColor
        contentView.layer.shadowOpacity = 0.7
        contentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        contentView.layer.shadowRadius = 2
        contentView.layer.masksToBounds = false
        
        contentView.addSubview(meaningLabel)
        NSLayoutConstraint.activate([
            meaningLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            meaningLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            meaningLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            meaningLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    func configure() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
