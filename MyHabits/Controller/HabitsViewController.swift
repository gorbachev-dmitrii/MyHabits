//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Dima Gorbachev on 15.02.2021.
//

import UIKit

class HabitsViewController: UIViewController {

    let store = HabitsStore.shared

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(named: "myWhite")
        view.backgroundColor = UIColor(named: "myWhite")
        configureNavigationBar()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: NSNotification.Name(rawValue: "closingModal"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("viewDidAppear")
        //store.todayProgress
    }
    
    @objc func presentModally() {
        let habitViewController = self.storyboard?.instantiateViewController(withIdentifier: "HabitViewController") as! HabitViewController
        let navBarOnModal: UINavigationController = UINavigationController(rootViewController: habitViewController)
        self.present(navBarOnModal, animated: true, completion: nil)
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentModally))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "myPurple")
        title = "Cегодня"
    }
    
    @objc func reloadCollectionView() {
        collectionView.reloadData()
    }
    // MARK: Set custom cells
    func setHabitCell(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        let habit = store.habits[indexPath.item]
        cell.habit = habit
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 0, bottom: 18, right: 0)
        }
}
