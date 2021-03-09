//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Dima Gorbachev on 15.02.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    private let containerView = UIView()
    private let scrollView = UIScrollView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont()
        label.text = "Привычка за 21 день"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.setBodyFont()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(views: [titleLabel, descriptionLabel])
        view.disableAutoresizingMask(views: [scrollView, containerView, titleLabel, descriptionLabel])
        setupConstraints()
        loadDescription()
        title = "Информация"
    }
    
    // MARK: Setup Constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -22)
            
        ])
    }
    
    func loadDescription() {
        if let filepath = Bundle.main.path(forResource: "Текст", ofType: "md") {
            do {
                let contents = try String(contentsOfFile: filepath)
                descriptionLabel.text = contents
            } catch {
                print("cannot read from file")
            }
        } else {
            print("cannot file the file ")
        }
    }
}
