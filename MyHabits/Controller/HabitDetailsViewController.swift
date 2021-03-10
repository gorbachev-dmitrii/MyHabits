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
    var index: Int?
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        return tableView
    }()
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "myWhite")
        view.addSubview(tableView)
        setupConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(goToRootVC), name: NSNotification.Name(rawValue: "goToRootVC"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func goToRootVC() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func configureNavigationBar() {
        // вот тут не меняется цвет кнопки "Назад", потому что она nil, но все же как изменить ее цвет?
        if let button = navigationItem.leftBarButtonItem {
            button.tintColor = UIColor(named: "myPurple")
        } else {
            print("button is nil")
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editHabit))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "myPurple")
        navigationItem.title = habit?.name
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @objc func editHabit() {
        let vc = HabitViewController()
        vc.habit = habit
        vc.index = index
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
    func createStringsArray() -> [String] {
        var array = [String]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        for date in store.dates {
            array.append(dateFormatter.string(from: date))
        }
        return array
    }
    // MARK: Constraints
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
        cell.textLabel?.text = createStringsArray()[indexPath.row]
        if store.habit(habit!, isTrackedIn: store.dates[indexPath.row]) {
            cell.accessoryType = .checkmark
            cell.tintColor = UIColor(named: "myPurple")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность"
    }
}

extension HabitDetailsViewController: UITableViewDelegate {

}

