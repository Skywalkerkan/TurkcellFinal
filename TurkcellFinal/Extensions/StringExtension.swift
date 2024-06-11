//
//  StringExtension.swift
//  TurkcellFinal
//
//  Created by Erkan on 11.06.2024.
//

import Foundation

extension String {
    
    func capitalizingFirstLetter() -> String {
        guard !self.isEmpty else {
            return self
        }
        
        let firstLetter = self.prefix(1).uppercased()
        let otherLetters = self.dropFirst().lowercased()
        
        return firstLetter + otherLetters
    }
}
