//
//  SearchCell.swift
//  TurkcellFinal
//
//  Created by Erkan on 6.06.2024.
//

import UIKit

class SearchCell: UITableViewCell {

    static let identifier = "SearchCell"
    
    let searchLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        
    }
    
    private func setupViews() {
        contentView.addSubview(searchLabel)
        NSLayoutConstraint.activate([
            searchLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            searchLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            searchLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            searchLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
