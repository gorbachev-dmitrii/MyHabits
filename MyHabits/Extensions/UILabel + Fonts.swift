//
//  UILabel + Fonts.swift
//  MyHabits
//
//  Created by Dima Gorbachev on 17.02.2021.
//

import UIKit

extension UILabel {
    
    func setTitleFont() {
        self.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.numberOfLines = 0
    }
    func setBodyFont() {
        self.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        self.numberOfLines = 0
    }
    
    func setHeadLineFont() {
        self.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        self.numberOfLines = 0
    }
    
    func setFootnoteFontUppercased() {
        self.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.text = text?.uppercased()
        self.numberOfLines = 0
    }
    
    func setFootnoteFont() {
        self.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        self.numberOfLines = 0
        self.textColor = .systemGray
    }
    
    func setFootnoteStatusFont() {
        self.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.numberOfLines = 0
        self.textColor = .systemGray
    }
    
    func setCaptionFont() {
        self.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        self.numberOfLines = 0
        self.textColor = .systemGray2
    }
}
