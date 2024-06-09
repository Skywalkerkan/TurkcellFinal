//
//  HomeViewController.swift
//  TurkcellFinal
//
//  Created by Erkan on 6.06.2024.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func setupTableView()
    func setupSearchController()
    func reloadData()
    func hideLoadingView()
    func showLoadingView()
    func getWordInfo()
    func getError(_ errorString: String)
}

final class HomeViewController: BaseViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let searchContainerView = UIView()
    private var chosenText: String?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var searchButton: UIButton = {
        let searchButton = UIButton(type: .system)
        searchButton.backgroundColor = .lightGray
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.layer.cornerRadius = 10
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        return searchButton
    }()
    
    @objc private func searchButtonClicked(){
        
        presenter.searchButtonClicked(word: chosenText)
    }
    
    var presenter: HomePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        presenter.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func dismissKeyboard() {
        searchController.searchBar.resignFirstResponder()
        searchController.isActive = false
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            
            let searchButtonCenterY = searchButton.superview!.convert(searchButton.frame.origin, to: nil).y
                let distanceToBottom = self.view.frame.height - searchButtonCenterY
                if keyboardHeight > distanceToBottom - 40 {
                    UIView.animate(withDuration: 0.3) {
                        let translationY = -(keyboardHeight - distanceToBottom + 60)
                        self.searchButton.transform = CGAffineTransform(translationX: 0, y: translationY)
                    }
                }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
           UIView.animate(withDuration: 0.3) {
               self.searchButton.transform = .identity
           }
       }
    
    
    private func setupViews() {
        view.backgroundColor = .white
        
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        if let searchTextField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            searchTextField.autocorrectionType = .no
        }
        searchController.searchBar.placeholder = "Search Words..."
        definesPresentationContext = true
        if let searchBarTextField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            searchBarTextField.backgroundColor = UIColor.white
        }
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        ])
        
        view.addSubview(searchButton)
        NSLayoutConstraint.activate([
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        

    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.fetchedSearches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        cell.searchLabel.text = presenter.fetchedSearches[indexPath.row].searchString
        return cell
    }
    
    
}

extension HomeViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
                 print("Search text: \(searchText)")

                chosenText = searchText
             }
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        print("ok")
    }
}


extension HomeViewController: HomeViewControllerProtocol {
    
    func hideLoadingView() {
        DispatchQueue.main.async {
            self.hideLoading()
        }
    }
    
    func showLoadingView() {
        DispatchQueue.main.async {
            self.showLoading()
        }
    }
    
    
    func getError(_ errorString: String) {
        DispatchQueue.main.async {
            self.showAlert(with: "Alert", message: errorString)
        }
    }
    
    
    func getWordInfo() {
        print("Aldık")
    }
    
    func setupTableView() {
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.delegate = self
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
