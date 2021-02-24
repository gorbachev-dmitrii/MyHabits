//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Dima Gorbachev on 19.02.2021.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    let store = HabitsStore.shared
    var habit: Habit? {
        didSet {
            titleLabel.text = habit?.name
            timeLabel.text =  habit?.dateString
            titleLabel.textColor = habit?.color
            trackButton.tintColor = habit?.color
            timesTrack.text = "Подряд: " + String((habit?.trackDates.count)!)
            checkHabitStatus()
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
    
    let trackButton: UIButton = {
        let button = UIButton(type: .custom)
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 36, left: 36, bottom: 36, right: 36)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(views: [titleLabel, timeLabel, timesTrack, trackButton])
        contentView.disableAutoresizingMask(views: [titleLabel, timeLabel, timesTrack, trackButton])
        setupConstraints()
        trackButton.addTarget(self, action: #selector(trackHabit), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFilled() {
        trackButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
    }
    func setEmpty() {
        trackButton.setImage(UIImage(systemName: "circle"), for: .normal)
    }
    
    func setFilledandSave() {
        store.track(habit!)
        setFilled()
    }
    
    func checkHabitStatus() {
        baseLogic(firstFunc: setFilled, secondFunc: setEmpty)
    }
    
    func baseLogic(firstFunc:() -> (), secondFunc:() -> ()) {
        if let bool = habit?.isAlreadyTakenToday {
            if bool {
                firstFunc()
            } else {
                // do smth else
                secondFunc()
            }
        } else {
            print("prishel nil")
        }
    }
    
    func smth() {
        print("уже затрекана сегодня")
    }
    
    @objc func trackHabit() {
        baseLogic(firstFunc: smth, secondFunc: setFilledandSave)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //trackButton.layer.borderColor
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            timesTrack.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            timesTrack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            trackButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 47),
            trackButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -47),
            trackButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            trackButton.widthAnchor.constraint(equalToConstant: 36),
            trackButton.heightAnchor.constraint(equalTo: trackButton.widthAnchor)
            
        ])
        
    }
}
