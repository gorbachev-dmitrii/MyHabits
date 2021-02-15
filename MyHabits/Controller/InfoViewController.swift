//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Dima Gorbachev on 15.02.2021.
//

import UIKit

class InfoViewController: UIViewController {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Привычка за 21 день"
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    func setupConstraints() {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
