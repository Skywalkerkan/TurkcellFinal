//
//  LaunchViewController.swift
//  TurkcellFinal
//
//  Created by Erkan on 4.06.2024.
//

import UIKit
import Lottie

protocol LaunchViewControllerProtocol: AnyObject {
    func setupCollectionView()
}

class LaunchViewController: UIViewController {
    
    var currentIndexPath: IndexPath = [0, 0]
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemGray6
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 2
        pageControl.pageIndicatorTintColor = UIColor.orange
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let nextItem = currentIndexPath.item + 1
        let nextIndexPath = IndexPath(item: nextItem, section: currentIndexPath.section)

        if currentIndexPath.row == 1 {
            presenter.navigateToHome()
        }else {
            self.currentIndexPath = nextIndexPath
            collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        presenter.navigateToHome()
    }
    
    var presenter: LaunchPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        presenter.viewDidLoad()
    }
    
    func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(continueButton)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            continueButton.widthAnchor.constraint(equalToConstant: 80),
            continueButton.heightAnchor.constraint(equalToConstant: 40),
            
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            skipButton.widthAnchor.constraint(equalToConstant: 80),
            skipButton.heightAnchor.constraint(equalToConstant: 40),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: -64),
        ])
    }

}

extension LaunchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.launchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchCell.identifier, for: indexPath) as! LaunchCell
        cell.configure(with: presenter.animations[indexPath.row], labelText: presenter.launchList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        currentIndexPath.row = Int(pageIndex)
    }
    
}

extension LaunchViewController: LaunchViewControllerProtocol {
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LaunchCell.self, forCellWithReuseIdentifier: LaunchCell.identifier)
    }
    
}


