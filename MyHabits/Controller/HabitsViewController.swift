//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Dima Gorbachev on 15.02.2021.
//

import UIKit

class HabitsViewController: UIViewController {

    let store = HabitsStore.shared
    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentModally))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "myPurple")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            HabitCollectionViewCell.self,
                    forCellWithReuseIdentifier: String(describing: HabitCollectionViewCell.self))
        view.addSubview(collectionView)
        setupConstraints()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(named: "myWhite")
        view.backgroundColor = UIColor(named: "myWhite")
        //store.habits.removeAll()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        let habit = store.habits[indexPath.item]
        cell.habit = habit
        return cell
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        return CGSize(width: width, height: 130)
    }
}
