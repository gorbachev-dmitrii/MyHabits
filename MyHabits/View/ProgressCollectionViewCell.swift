//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Dima Gorbachev on 20.02.2021.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    let store = HabitsStore.shared
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.setFootnoteStatusFont()
        label.text = "Все получится!"
        return label
    }()
    let percentLabel: UILabel = {
        let label = UILabel()
        label.setFootnoteFont()
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
    // MARK: Init and lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(views: [titleLabel, progressView, percentLabel])
        contentView.disableAutoresizingMask(views: [titleLabel, progressView, percentLabel])
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        progressView.progress = store.todayProgress
        percentLabel.text = String(Int(progressView.progress * 100)) + "%"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            percentLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            percentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            progressView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            progressView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            progressView.heightAnchor.constraint(equalToConstant: 7)
        ])
    }
}
