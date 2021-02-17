//
//  Public.swift
//  MyHabits
//
//  Created by Dima Gorbachev on 17.02.2021.
//

import UIKit

extension UIView {
    
    public func disableAutoresizingMask(views: [UIView]) {
        views.forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
    }
    public func addSubviews(views: [UIView]) {
        views.forEach({
            self.addSubview($0)
        })
    }
}
