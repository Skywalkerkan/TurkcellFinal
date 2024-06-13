//
//  CustomCell.swift
//  TurkcellFinal
//
//  Created by Erkan on 13.06.2024.
//

import UIKit

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
