//
//  UIView + AddShadow.swift
//  TurkcellFinal
//
//  Created by Erkan on 12.06.2024.
//

import UIKit

extension UIView {
    func applyShadow(
        shadowColor: UIColor = .systemGray,
        shadowOpacity: Float = 0.7,
        shadowOffset: CGSize = CGSize(width: 1, height: 1),
        shadowRadius: CGFloat = 4
    ) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = false
    }
}
