//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Dima Gorbachev on 19.02.2021.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    var habit: Habit? {
        didSet {
            titleLabel.text = habit?.name
            timeLabel.text =  habit?.dateString
            titleLabel.textColor = habit?.color
            timesTrack.text = "Подряд: " + String((habit?.trackDates.count)!)
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.setHeadLineFont()
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.setCaptionFont()
        return label
    }()
    
    let timesTrack: UILabel = {
        let label = UILabel()
        label.setFootnoteFont()
        return label
    }()
    
//    let trackButton: UIButton = {
//        let button = UIButton()
////        button.addTarget(self, action: #selector(showColorPicker), for: .touchUpInside)
//        return button
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(views: [titleLabel, timeLabel, timesTrack])
        contentView.disableAutoresizingMask(views: [titleLabel, timeLabel, timesTrack])
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            timesTrack.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            timesTrack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
    }
}
