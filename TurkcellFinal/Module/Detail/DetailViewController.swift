//
//  DetailViewController.swift
//  TurkcellFinal
//
//  Created by Erkan on 6.06.2024.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func setupTableView()
    func reloadData()
    
}


final class DetailViewController: BaseViewController {
    
     private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .red
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let tableView: SelfSizingTableView = {
        let tableView = SelfSizingTableView()
        tableView.backgroundColor = .red
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var source: [WordResult]?
    var presenter: DetailPresenter!
    
    
    override func viewDidLoad() {
        setupViews()
        presenter.viewDidload(word: source?.first?.word)
        
    }
    
    private func setupViews() {
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            // ScrollView constraints
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // StackView constraints
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
    
        ])
        
        stackView.addArrangedSubview(tableView)
        
        tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 100 // Provide an estimated row height for better scroll performance
    }


}


class SelfSizingTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        self.isScrollEnabled = false
    }

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }

    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        cell.searchLabel.text = "oksadfsdLŞDSKAŞLGAKSLŞGDASKLŞFSAŞKFDASŞLFKASDŞLKŞKFAŞLSDALŞFKSADFAKSŞLDASDFMASD"
        return cell
    }
    
}

extension DetailViewController: DetailViewControllerProtocol {
    
    func setupTableView() {
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            print(self.presenter.allSynonyms)
        }
    }
    
}
