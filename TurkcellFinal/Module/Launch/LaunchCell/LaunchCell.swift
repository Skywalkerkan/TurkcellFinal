//
//  LaunchCell.swift
//  TurkcellFinal
//
//  Created by Erkan on 4.06.2024.
//

import UIKit
import Lottie

class LaunchCell: UICollectionViewCell {
    
    static let identifier = "LaunchCell"
    
    private let launchAnimationView: LottieAnimationView = {
        let LottieAnimation = LottieAnimationView()
        LottieAnimation.loopMode = .loop
        LottieAnimation.animationSpeed = 1.0
        LottieAnimation.translatesAutoresizingMaskIntoConstraints = false
        return LottieAnimation
    }()
    
    let launchLabel: UILabel = {
        let label = UILabel()
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
        contentView.addSubview(launchAnimationView)
        contentView.addSubview(launchLabel)
        
        NSLayoutConstraint.activate([
            launchAnimationView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant:  -100),
            launchAnimationView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            launchAnimationView.widthAnchor.constraint(equalToConstant: 200),
            launchAnimationView.heightAnchor.constraint(equalToConstant: 200),

            launchLabel.topAnchor.constraint(equalTo: launchAnimationView.bottomAnchor, constant: -32),
            launchLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            launchLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

        ])
        
    }
    
    func configure(with animationName: String, labelText: String) {
         launchLabel.text = labelText
         
         if let animation = LottieAnimation.named(animationName) {
             launchAnimationView.animation = animation
             launchAnimationView.play()
         }
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
