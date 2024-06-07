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

class SplashViewController: UIViewController {

    let splashImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var presesenter: SplashPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(splashImage)
        splashImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        splashImage.widthAnchor.constraint(equalToConstant: 200).isActive = true

        presesenter.viewDidAppear()

    }
    


}

extension SplashViewController: SplashViewControllerProtocol{
    
    func noInternetConnection() {
        
    }
}
