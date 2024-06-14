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
    func getError(_ errorString: String)
}

final class HomeViewController: BaseViewController {
    
    private lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.backgroundColor = .white
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search Your Word..."
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.layer.borderColor = UIColor.systemGray4.cgColor
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.searchTextField.layer.cornerRadius = 12
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
              let attributes: [NSAttributedString.Key: Any] = [
                  .foregroundColor: UIColor.lightGray,
                  .font: UIFont.systemFont(ofSize: 17)
              ]
              searchTextField.attributedPlaceholder = NSAttributedString(string: "Search Your Word", attributes: attributes)
          }
        searchBar.searchTextField.leftView?.tintColor = .gray
        searchBar.layer.zPosition = 2
        searchBar.accessibilityIdentifier = "searchBar"
        return searchBar
    }()
    
    private var chosenText: String?
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Handy Dictionary"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let noRecentSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "There is no recent search"
        label.isHidden = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let noRecentSearchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "nosearch")
        imageView.isHidden = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let tableView: SelfSizingTableView = {
        let tableView = SelfSizingTableView()
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 12
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor =  UIColor.systemGray4.cgColor
        tableView.sectionHeaderTopPadding = 0
        tableView.bouncesVertically = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var searchButton: UIButton = {
        let searchButton = UIButton(type: .system)
        searchButton.backgroundColor = UIColor(red: 247/255, green: 150/255, blue: 71/255, alpha: 1)
        searchButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.layer.cornerRadius = 8
        searchButton.layer.shadowColor = UIColor.black.cgColor
        searchButton.layer.shadowOpacity = 0.7
        searchButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        searchButton.layer.shadowRadius = 4
        searchButton.layer.masksToBounds = false     
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        searchButton.accessibilityIdentifier = "SearchButton"
        return searchButton
    }()
    
    @objc private func searchButtonClicked(){
        searchBar.resignFirstResponder()
        presenter.searchButtonClicked(word: chosenText)
    }
    
    
    private lazy var recentSearchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Recent Searches", for: .normal)
        button.addTarget(self, action: #selector(recentSearchClicked), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func recentSearchClicked(){
        
    }
    
    var presenter: HomePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        tapGesture.delegate = self
        contentView.addGestureRecognizer(tapGesture)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewDidLoad()
    }
    
    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
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
        view.backgroundColor = .systemGray6
        
        view.addSubview(contentView)
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(searchButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(recentSearchButton)
        contentView.addSubview(noRecentSearchLabel)
        contentView.addSubview(noRecentSearchImageView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -4),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            searchBar.heightAnchor.constraint(equalToConstant: 50),

            recentSearchButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            recentSearchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            recentSearchButton.heightAnchor.constraint(equalToConstant: 25),
            
            tableView.topAnchor.constraint(equalTo: recentSearchButton.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            noRecentSearchImageView.widthAnchor.constraint(equalToConstant: 130),
            noRecentSearchImageView.heightAnchor.constraint(equalToConstant: 130),
            noRecentSearchImageView.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 70),
            noRecentSearchImageView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),

            noRecentSearchLabel.topAnchor.constraint(equalTo: noRecentSearchImageView.bottomAnchor, constant: 0),
            noRecentSearchLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),

            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        navigationController?.navigationBar.isHidden = true
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        let word = presenter.fetchedSearches[indexPath.row].searchString
        presenter.didSelectRowAt(word)
    }
    
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            chosenText = searchText
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
            self.showAlert(with: "Alert", message: "We could not find your word please write a word appropriately")
        }
    }
    
    func setupTableView() {
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupSearchController() {
        searchBar.delegate = self
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            if self.presenter.fetchedSearches.isEmpty {
                self.noRecentSearchLabel.isHidden = false
                self.noRecentSearchImageView.isHidden = false
                self.recentSearchButton.isHidden = true
            }else{
                self.noRecentSearchLabel.isHidden = true
                self.noRecentSearchImageView.isHidden = true
                self.recentSearchButton.isHidden = false
            }
            self.tableView.reloadData()
        }
    }
    
}

extension HomeViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if gestureRecognizer == tapGesture {
            searchBar.resignFirstResponder()
            return false
        }
            return true
    }
}
