//
//  SplashViewController.swift
//  TurkcellFinal
//
//  Created by Erkan on 30.05.2024.
//

import UIKit

protocol SplashViewControllerProtocol: AnyObject{
    func noInternetConnection()
}

class SplashViewController: BaseViewController {

    private let splashImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dictionary")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let splashLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Dictionary In Your Hand"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var presesenter: SplashPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        view.addSubview(splashImage)
        view.addSubview(splashLabel)

        splashImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80).isActive = true
        splashImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        splashImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        splashImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        splashLabel.topAnchor.constraint(equalTo: splashImage.bottomAnchor,constant: 16).isActive = true
        splashLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16).isActive = true
        splashLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16).isActive = true

        presesenter.viewDidAppear()

    }

}

extension SplashViewController: SplashViewControllerProtocol{
    
    func noInternetConnection() {
        showAlert(
            with: "Error",
            message: "No internet connection, please check your connection"
        )
    }
}
