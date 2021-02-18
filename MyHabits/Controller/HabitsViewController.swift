//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Dima Gorbachev on 15.02.2021.
//

import UIKit

class HabitsViewController: UIViewController {

    let store = HabitsStore.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentModally))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "myPurple")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print(store.habits[0].name)
    }
    
    @objc func presentModally() {
        let habitViewController = self.storyboard?.instantiateViewController(withIdentifier: "HabitViewController") as! HabitViewController
        let navBarOnModal: UINavigationController = UINavigationController(rootViewController: habitViewController)
        self.present(navBarOnModal, animated: true, completion: nil)
    }
}
