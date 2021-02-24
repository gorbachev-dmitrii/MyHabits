//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Dima Gorbachev on 20.02.2021.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    let store = HabitsStore.shared
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.setFootnoteStatusFont()
        label.text = "Все получится"
        return label
    }()
    
    let progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.progressViewStyle = .bar
        progress.progressTintColor = UIColor(named: "myPurple")
        progress.backgroundColor = .systemGray2
        progress.layer.cornerRadius = 4
        progress.clipsToBounds = true
        return progress
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(views: [titleLabel, progressView])
        contentView.disableAutoresizingMask(views: [titleLabel, progressView])
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        progressView.progress = store.todayProgress
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            progressView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            progressView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            progressView.heightAnchor.constraint(equalToConstant: 7)
        ])
    }
}
