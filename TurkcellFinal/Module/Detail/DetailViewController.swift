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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let wordLabel: UILabel = {
       let label = UILabel()
        label.text = "Home"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pronounceLabel: UILabel = {
       let label = UILabel()
        label.text = "homesa"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var soundButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.systemGray.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowRadius = 4
        button.layer.masksToBounds = false
        let image = UIImage(systemName: "person.wave.2")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(soundButtonClicked), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return button
    }()


    var player: AVPlayer?
    
    @objc private func soundButtonClicked() {
        if let audioURL = presenter.didSoundButtonClicked() {
            playAudio(from: audioURL)
        } else{
            print("yokki")
        }
    }
    
    func playAudio(from url: URL) {
        player = AVPlayer(url: url)
        player?.play()
    }
    
    private let meaningsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let tableView: SelfSizingTableView = {
        let tableView = SelfSizingTableView()
        tableView.backgroundColor = .systemGray6
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let synonymCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var source: [WordResult]?
    var presenter: DetailPresenter!
    
    
    override func viewDidLoad() {
        setupViews()
        presenter.viewDidload(word: source?.first?.word, source: source)
        
        
        wordLabel.text = source?.first?.word
        pronounceLabel.text = source?.first?.phonetic
        
    }
    
    private func setupViews() {
        let backImage = UIImage(systemName: "arrowshape.left.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemCyan)
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        let backButton = UIBarButtonItem(image: nil, style: .done, target: nil, action: nil)
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        view.backgroundColor = .white
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
        headerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        headerView.addSubview(wordLabel)
        headerView.addSubview(pronounceLabel)
        headerView.addSubview(soundButton)
        
        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 16),
            wordLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            
            pronounceLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 8),
            pronounceLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            
            soundButton.topAnchor.constraint(equalTo: wordLabel.topAnchor),
            soundButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -24),
            soundButton.heightAnchor.constraint(equalToConstant: 40),
            soundButton.widthAnchor.constraint(equalToConstant: 40)

        ])
        
        stackView.addArrangedSubview(meaningsCollectionView)
        meaningsCollectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        stackView.addArrangedSubview(tableView)
        
        stackView.addArrangedSubview(synonymCollectionView)
        synonymCollectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        tableView.rowHeight = UITableView.automaticDimension
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

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case meaningsCollectionView: 
          //  return source?.first?.meanings?.count ?? 0
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
            //cell.meaningLabel.text = source?.first?.meanings?[indexPath.row].partOfSpeech
            
            if presenter.isItFiltering && indexPath.row == 0{
                cell.contentView.layer.borderColor = UIColor.red.cgColor
                cell.meaningLabel.textColor = .red
                cell.contentView.layer.cornerRadius = 18
            }else if presenter.isItFiltering && indexPath.row == 1{
                cell.contentView.layer.borderColor = UIColor.systemCyan.cgColor
                cell.meaningLabel.textColor = .black
              }else{
                  cell.contentView.layer.borderColor = UIColor.black.cgColor
                  cell.meaningLabel.textColor = .black
              }
            
            cell.meaningLabel.text = presenter.partOfSpeech(index: indexPath.row)
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
            //let phrase = source?.first?.meanings?[indexPath.row].partOfSpeech
            if presenter.isItFiltering && indexPath.row == 0{
                presenter.deleteClicked()
            }else if presenter.isItFiltering && indexPath.row == 1{
                break
            } else{
                let phrase = presenter.partOfSpeech(index: indexPath.row)
                presenter.partOfSpeechDidSelect(selectedPhrase: phrase, indexPath: indexPath)
            }
          
        case synonymCollectionView:
            break
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
      //  return source?.first?.meanings?.count ?? 0
        return presenter.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return source?.first?.meanings?[section].definitions?.count ?? 0
        return presenter.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.identifier, for: indexPath) as! InfoCell
        
        let partOfSpeech = presenter.cellForRowAt(index: indexPath.section)
        cell.partOfSpeechLabel.text = "\(indexPath.row + 1) " + (partOfSpeech?.partOfSpeech ?? "")
        
        cell.definitionLabel.text = presenter.cellForRowAt(index: indexPath.section)?.definitions?[indexPath.row].definition

        if let definitions = presenter.cellForRowAt(index: indexPath.section)?.definitions, let example = definitions[indexPath.row].example{
            cell.exampleLabel.text = example
        }else{
            cell.exampleLabel.text = ""
        }


        /*if let meaning = source?.first?.meanings?[indexPath.section] {
            let partOfSpeech = meaning.partOfSpeech
            cell.partOfSpeechLabel.text = "\(indexPath.row + 1) " + (partOfSpeech ?? "")
        }
        
        if let definitions = source?.first?.meanings?[indexPath.section].definitions {
            cell.definitionLabel.text = definitions[indexPath.row].definition
        }
        
        if let definitions = source?.first?.meanings?[indexPath.section].definitions, let example = definitions[indexPath.row].example {
            cell.exampleLabel.text = "Example: " + example
        }*/

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
           // Başlık görünümüne özel köşe yarıçapı verme
           if let headerView = view as? UITableViewHeaderFooterView {
               // İstediğiniz köşe yarıçapını ayarlayın
               headerView.layer.cornerRadius = 10 // Örnek değer
               headerView.clipsToBounds = true
           }
       }
       
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
           // Altbilgi görünümüne özel köşe yarıçapı verme
           if let footerView = view as? UITableViewHeaderFooterView {
               // İstediğiniz köşe yarıçapını ayarlayın
               footerView.layer.cornerRadius = 10 // Örnek değer
               footerView.clipsToBounds = true
           }
       }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        10
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .red
        return UIView()
    }
        
    
}

extension DetailViewController: DetailViewControllerProtocol {
    
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
            self.tableView.reloadData()
            self.meaningsCollectionView.reloadData()
            self.synonymCollectionView.reloadData()
        }
    }
    
}
