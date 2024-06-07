//
//  LaunchCell.swift
//  TurkcellFinal
//
//  Created by Erkan on 4.06.2024.
//

import UIKit

class LaunchCell: UICollectionViewCell {
    
    static let identifier = "LaunchCell"
    
    private let launchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let launchLabel: UILabel = {
        let label = UILabel()
        label.text = "Öyle böylasgafsgfaldska lşaskjfşadjklfadjfkadjfkadjflkadjflkadjlfkdsajfklşdajfsdkaşfjkdalkasklgjadske"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    func setupViews() {
        contentView.addSubview(launchImageView)
        contentView.addSubview(launchLabel)
        
        NSLayoutConstraint.activate([
            launchImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant:  -100),
            launchImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            launchImageView.widthAnchor.constraint(equalToConstant: 100),
            launchImageView.heightAnchor.constraint(equalToConstant: 100),

            launchLabel.topAnchor.constraint(equalTo: launchImageView.bottomAnchor, constant: 16),
            launchLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            launchLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
