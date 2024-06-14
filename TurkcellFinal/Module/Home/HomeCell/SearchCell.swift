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
    
    let arrowImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysOriginal).withTintColor(.lightGray)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        
    }
    
    private func setupViews() {
        contentView.addSubview(searchLabel)
        contentView.addSubview(arrowImageView)
        NSLayoutConstraint.activate([
            searchLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            searchLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            searchLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
