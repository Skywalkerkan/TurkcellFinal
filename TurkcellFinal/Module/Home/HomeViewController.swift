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
        return searchBar
    }()
    
    private var chosenText: String?
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tableView: SelfSizingTableView = {
        let tableView = SelfSizingTableView()
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 12
        tableView.sectionHeaderTopPadding = 0
        tableView.bouncesVertically = false
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
        searchBar.resignFirstResponder()
        presenter.searchButtonClicked(word: chosenText)
        print("evet devamke")
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
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        let word = presenter.fetchedSearches[indexPath.row].searchString
        presenter.didSelectRowAt(word)
    }
    
}

extension HomeViewController: UISearchBarDelegate {
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3) {
            var frameSearchBar = self.searchBar.frame
            var frameTableView = self.tableView.frame
            
            frameSearchBar.origin.y -= 30
            self.searchBar.frame = frameSearchBar
            frameTableView.origin.y -= 20
            self.tableView.frame = frameTableView
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3) {
            var frameSearchBar = self.searchBar.frame
            var frameTableView = self.tableView.frame
            
            frameSearchBar.origin.y += 30
            self.searchBar.frame = frameSearchBar
            frameTableView.origin.y += 20
            self.tableView.frame = frameTableView
        }
    }
    
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
    
    
    func getWordInfo() {

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
