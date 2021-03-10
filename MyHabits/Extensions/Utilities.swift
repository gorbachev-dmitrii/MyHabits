//
//  Support.swift
//  MyHabits
//
//  Created by Dima Gorbachev on 04.03.2021.
//

import Foundation

func postToRootMessage() {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "goToRootVC"), object: nil)
    print("goToRootVC")
}
