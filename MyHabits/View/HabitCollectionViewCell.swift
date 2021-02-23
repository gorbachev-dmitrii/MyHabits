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
            trackButton.tintColor = habit?.color
            //trackButton.backgroundColor = habit?.color
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
    
    let trackButton: UIButton = {
        let button = UIButton(type: .custom)
       // button.layer.cornerRadius = 18
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        //button.backgroundColor = .gray
        
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 36, left: 36, bottom: 36, right: 36)
        //button.isUserInteractionEnabled = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(views: [titleLabel, timeLabel, timesTrack, trackButton])
        contentView.disableAutoresizingMask(views: [titleLabel, timeLabel, timesTrack, trackButton])
        setupConstraints()
        trackButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        //trackButton.backgroundImage(for: .normal) = UIImage(systemName: "circle")
        //trackButton.setImage(UIImage(systemName: "circle"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonPressed() {
        print("alalalal")
        trackButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        if let bool = habit?.isAlreadyTakenToday {
            print(bool)
        } else {
            print("hz")
        }
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
