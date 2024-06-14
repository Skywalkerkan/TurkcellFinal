//
//  DetailViewController.swift
//  TurkcellFinal
//
//  Created by Erkan on 6.06.2024.
//

import UIKit
import AVFoundation

protocol DetailViewControllerProtocol: AnyObject {
    func setupTableView()
    func setupCollectionViews()
    func reloadData()
    func hideLoadingView()
    func showLoadingView()
    func getError(_ error: String)
}

final class DetailViewController: BaseViewController {
    
    private let factoryView = DetailInfoFactoryView()
    
    private lazy var scrollView: UIScrollView = {
        return factoryView.createScrollView()
    }()
    
    private lazy var stackView: UIStackView = {
        return factoryView.createStackView()
    }()
    
    private lazy var headerView: UIView = {
        return factoryView.createTopView()
    }()
    
    private lazy var headerStackView: UIStackView = {
        return factoryView.createStackView()
    }()
    
    private lazy var wordLabel: UILabel = {
        return factoryView.createWordLabel()
    }()
    
    private lazy var pronounceLabel: UILabel = {
        return factoryView.createPronounceLabel()
    }()
    
    private lazy var soundButton: UIButton = {
        return factoryView.createSoundButton(target: self, action: #selector(soundButtonClicked))
    }()

    var player: AVPlayer?
    
    @objc private func soundButtonClicked() {
        if let audioURL = presenter.soundButton() {
            playAudio(from: audioURL)
        } else{

        }
    }
    
    func playAudio(from url: URL) {
        player = AVPlayer(url: url)
        player?.play()
    }
    
    private lazy var meaningsCollectionView: UICollectionView = {
        return factoryView.createMeaningsCollectionView()
    }()
    
    private lazy var tableView: SelfSizingTableView = {
        return factoryView.createTableView()
    }()
    
    private lazy var synonymLabel: UILabel = {
        return factoryView.createSynonymLabel()
    }()
    
    private lazy var noSynonymLabel: UILabel = {
        return factoryView.createNoSynonymLabel()
    }()
    
    private lazy var synonymCollectionView: UICollectionView = {
        return factoryView.createSynonymCollectionView()
    }()
    
    private lazy var footerSpaceView: UIView = {
        return factoryView.createFooterView()
    }()
    
    var source: [WordResult]?
    var presenter: DetailPresenter!
    
    
    override func viewDidLoad() {
        setupViews()
        presenter.viewDidload(word: source?.first?.word, source: source)
        
        configureViews()
        
    }
    
    private func configureViews() {
        navigationController?.navigationBar.isHidden = false
        self.wordLabel.text = presenter?.sourceDetail?.first?.word
        if let pronounce = self.presenter.sourceDetail?.first?.phonetic {
            self.pronounceLabel.text = pronounce
        } else if let phonetics = self.presenter.sourceDetail?.first?.phonetics, phonetics.indices.contains(1) {
            let pronunce = phonetics[1].text
            self.pronounceLabel.text = pronunce
        } else {
            self.pronounceLabel.text = ""
        }
        if presenter.soundButton() != nil {
            DispatchQueue.main.async {
                let image = UIImage(systemName: "person.wave.2")?
                    .withRenderingMode(.alwaysOriginal)
                    .withTintColor(.black)
                self.soundButton.setImage(image, for: .normal)
                self.soundButton.isUserInteractionEnabled = true
            }
        } else {
            DispatchQueue.main.async {
                let image = UIImage(systemName: "person.wave.2")?
                    .withRenderingMode(.alwaysOriginal)
                    .withTintColor(.lightGray)
                self.soundButton.setImage(image, for: .normal)
                self.soundButton.isUserInteractionEnabled = false
            }
        }
        
        if presenter.allSynonyms?.count == 0 {
            synonymLabel.isHidden = true
            noSynonymLabel.isHidden = false
        } else {
            synonymLabel.isHidden = false
            noSynonymLabel.isHidden = true
        }
    }
    
    private func setupViews() {
        
        view.backgroundColor = .systemGray6
        
        let backImage = UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemCyan)
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        let backButton = UIBarButtonItem(image: nil, style: .done, target: nil, action: nil)
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        view.backgroundColor = UIColor(red: 242/255, green: 241/255, blue: 246/255, alpha: 1)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        stackView.addArrangedSubview(headerView)
        headerView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        headerView.addSubview(wordLabel)
        headerView.addSubview(pronounceLabel)
        headerView.addSubview(soundButton)
        headerView.addSubview(meaningsCollectionView)
        
        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 4),
            wordLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            
            pronounceLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 8),
            pronounceLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            
            soundButton.topAnchor.constraint(equalTo: wordLabel.topAnchor),
            soundButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -24),
            soundButton.heightAnchor.constraint(equalToConstant: 40),
            soundButton.widthAnchor.constraint(equalToConstant: 40),
            
            meaningsCollectionView.topAnchor.constraint(equalTo: pronounceLabel.bottomAnchor, constant: 8),
            meaningsCollectionView.heightAnchor.constraint(equalToConstant: 50),
            meaningsCollectionView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 0),
            meaningsCollectionView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 0)
        ])
        
        let tableViewWrapper = UIView()
        tableViewWrapper.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: tableViewWrapper.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: tableViewWrapper.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: tableViewWrapper.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: tableViewWrapper.bottomAnchor)
        ])
        stackView.addArrangedSubview(tableViewWrapper)
        stackView.setCustomSpacing(16, after: tableViewWrapper)
        
        let synonymLabelWrapper = UIView()
        synonymLabelWrapper.addSubview(synonymLabel)
        NSLayoutConstraint.activate([
            synonymLabel.leadingAnchor.constraint(equalTo: synonymLabelWrapper.leadingAnchor, constant: 16),
            synonymLabel.trailingAnchor.constraint(equalTo: synonymLabelWrapper.trailingAnchor, constant: -16),
            synonymLabel.topAnchor.constraint(equalTo: synonymLabelWrapper.topAnchor),
            synonymLabel.bottomAnchor.constraint(equalTo: synonymLabelWrapper.bottomAnchor)
        ])
        stackView.addArrangedSubview(synonymLabelWrapper)
        
        view.addSubview(noSynonymLabel)
        noSynonymLabel.topAnchor.constraint(equalTo: synonymLabelWrapper.bottomAnchor, constant: -8).isActive = true
        noSynonymLabel.centerXAnchor.constraint(equalTo: synonymLabelWrapper.centerXAnchor).isActive = true
                
        stackView.addArrangedSubview(synonymCollectionView)
        synonymCollectionView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tableView.rowHeight = UITableView.automaticDimension
        
        stackView.addArrangedSubview(footerSpaceView)
        footerSpaceView.heightAnchor.constraint(equalToConstant: 12).isActive = true
    }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case meaningsCollectionView: 
            return presenter.partOfSpeechCount()
        case synonymCollectionView:
            return presenter.allSynonyms?.count ?? 0
        
        default:
           break
        }
        return Int()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case meaningsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MeaningCell.identifier, for: indexPath) as! MeaningCell
            let meaningText = presenter.partOfSpeech(index: indexPath.row)
            let isFiltering = presenter.isItFiltering
            cell.configure(with: meaningText, isFiltering: isFiltering, indexPath: indexPath)
            return cell
        case synonymCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SynonymCell.identifier, for: indexPath) as! SynonymCell
            cell.synonymLabel.text = presenter.allSynonyms?[indexPath.row].word
            return cell
        default:
            break
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case meaningsCollectionView:
            if presenter.isItFiltering && indexPath.row == 0{
                presenter.deleteClicked()
            }else if presenter.isItFiltering && indexPath.row == 1{
                break
            } else{
                let phrase = presenter.partOfSpeech(index: indexPath.row)
                presenter.partOfSpeechDidSelect(selectedPhrase: phrase, indexPath: indexPath)
            }
          
        case synonymCollectionView:
            if let synonym = presenter.allSynonyms?[indexPath.row].word {
                presenter.didSelectSynonym(synonym)
            }
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.identifier, for: indexPath) as! InfoCell
        
        cell.partOfSpeechLabel.text = "\(indexPath.row + 1)"
        
        if let definitions = presenter.cellForRowAt(index: indexPath.section)?.definitions, indexPath.row < definitions.count {
            let definition = definitions[indexPath.row]
            let index = "\(indexPath.row + 1)  "
            cell.cellPresenter = InfoCellPresenter(view: cell, definition: definition, index: index)
        } else {

        }
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = DetailInfoFactoryView.createHeaderView()
        let partOfSpeechLabel = DetailInfoFactoryView.createPartOfSpeechLabel()
        let imageView = DetailInfoFactoryView.createImageView()

        view.addSubview(imageView)
        view.addSubview(partOfSpeechLabel)
        DetailInfoFactoryView.setupConstraints(for: view, imageView: imageView, label: partOfSpeechLabel)
        let partOfSpeech = presenter.cellForRowAt(index: section)
        partOfSpeechLabel.text = partOfSpeech?.partOfSpeech
        
        return view
    }

    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return DetailInfoFactoryView.createFooterView()
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    
    func hideLoadingView() {
        DispatchQueue.main.async {
            self.hideLoading()
            let topOffset = -self.scrollView.safeAreaInsets.top
            self.scrollView.setContentOffset(CGPoint(x: 0, y: topOffset), animated: false)
        }
    }
    
    func showLoadingView() {
        DispatchQueue.main.async {
            self.showLoading()
        }
    }
    
    func setupTableView() {
        tableView.register(InfoCell.self, forCellReuseIdentifier: InfoCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupCollectionViews() {
        synonymCollectionView.register(SynonymCell.self, forCellWithReuseIdentifier: SynonymCell.identifier)
        synonymCollectionView.delegate = self
        synonymCollectionView.dataSource = self
        
        meaningsCollectionView.register(MeaningCell.self, forCellWithReuseIdentifier: MeaningCell.identifier)
        meaningsCollectionView.delegate = self
        meaningsCollectionView.dataSource = self
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.configureViews()
            self.tableView.reloadData()
            self.meaningsCollectionView.reloadData()
            self.synonymCollectionView.reloadData()
        }
    }
    
    func getError(_ error: String) {
        DispatchQueue.main.async {
            self.showAlert(with: "Alert", message: "We could not find chosen word.")
        }
    }
}
