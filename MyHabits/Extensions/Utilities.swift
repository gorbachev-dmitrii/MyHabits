//
//  Support.swift
//  MyHabits
//
//  Created by Dima Gorbachev on 04.03.2021.
//

import Foundation

func postReloadMessage() {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadData"), object: nil)
    print("reloadData")
}
func postToRootMessage() {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "goToRootVC"), object: nil)
    print("goToRootVC")
}
