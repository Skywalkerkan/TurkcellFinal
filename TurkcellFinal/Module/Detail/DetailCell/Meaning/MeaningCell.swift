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
    
    func configure(with meaningText: String, isFiltering: Bool, indexPath: IndexPath) {
           meaningLabel.text = meaningText
           
           if isFiltering {
               switch indexPath.row {
               case 0:
                   contentView.backgroundColor = UIColor(red: 250/255, green: 80/255, blue: 80/255, alpha: 0.8)
                   contentView.layer.borderColor = UIColor.clear.cgColor
                   meaningLabel.textColor = .white
               case 1:
                   contentView.backgroundColor = UIColor(red: 247/255, green: 150/255, blue: 71/255, alpha: 0.9)
                   contentView.layer.borderColor = UIColor.clear.cgColor
                   meaningLabel.textColor = .white
               default:
                   contentView.layer.borderColor = UIColor.gray.cgColor
                   contentView.backgroundColor = .white
                   meaningLabel.textColor = .black
               }
           } else {
               contentView.layer.borderColor = UIColor.gray.cgColor
               contentView.backgroundColor = .white
               meaningLabel.textColor = .black
           }
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
