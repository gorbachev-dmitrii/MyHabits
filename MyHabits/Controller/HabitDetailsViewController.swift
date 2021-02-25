//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Dima Gorbachev on 25.02.2021.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    // MARK: Properties
    let store = HabitsStore.shared
    var habit: Habit?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.backgroundColor = UIColor(named: "myWhite")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "myWhite")
        view.addSubview(tableView)
        setupConstraints()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        // вот тут не меняется цвет кнопки "Назад", не пойму, почему(
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "myPurple")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editHabit))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "myPurple")
        navigationItem.title = habit?.name
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    @objc func editHabit() {
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        
        cell.textLabel?.text = "alalla"
        return cell
    }
    
    
}

extension HabitDetailsViewController: UITableViewDelegate {
    
}

