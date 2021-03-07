//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Dima Gorbachev on 15.02.2021.
//

import UIKit

class HabitsViewController: UIViewController {


    let vc = HabitViewController()
    let store = HabitsStore.shared
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor(named: "myWhite")
        collection.dataSource = self
        collection.delegate = self
        collection.register(
            HabitCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: HabitCollectionViewCell.self))
        collection.register(
            ProgressCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: ProgressCollectionViewCell.self))
        return collection
    }()
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        setupConstraints()
        vc.delegate = self
        view.backgroundColor = UIColor(named: "myWhite")
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: NSNotification.Name(rawValue: "reloadData"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureNavigationBar()
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("viewDidAppear")
    }
    
    @objc func presentHabitVC() {
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentHabitVC))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "myPurple")
//        navigationItem.largeTitleDisplayMode = .always
//        navigationController?.navigationBar.prefersLargeTitles = true
//        let appearance = UINavigationBarAppearance()
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = "Cегодня"
    }
    
    @objc func reloadCollectionView() {
        collectionView.reloadData()
    }
//    func reloadData() {
//        collectionView.reloadData()
//    }
    // MARK: Set custom cells
    func setHabitCell(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        cell.habit = store.habits[indexPath.item]
        return cell
    }
    
    func setProgressCell(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath)
        cell.layer.cornerRadius = 8
        cell.backgroundColor = .white
        return cell
    }
}
// MARK: UICollectionViewDataSource
extension HabitsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section > 0 ? store.habits.count : 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return indexPath.section > 0
            ? setHabitCell(indexPath: indexPath)
            : setProgressCell(indexPath: indexPath)
    }
}
// MARK: UICollectionViewDelegateFlowLayout
extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        return indexPath.section > 0
            ? CGSize(width: width, height: 130)
            : CGSize(width: width, height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HabitDetailsViewController()
        if indexPath.section > 0 {
            let habit = store.habits[indexPath.item]
            vc.habit = habit
            navigationController?.pushViewController(vc, animated: true)
        } else {
            print("no cell to push")
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 22, left: 0, bottom: 18, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 18, right: 0)
        }
    }
}

extension HabitsViewController: ReloadDataDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
