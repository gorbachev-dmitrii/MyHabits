//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Dima Gorbachev on 16.02.2021.
//

import UIKit

class HabitViewController: UIViewController {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Название"
        label.setFootnoteFont()
        return label
    }()
    let titleInput: UITextField = {
        let input = UITextField()
        input.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        input.textColor = .systemGray2
        return input
    }()
    
    let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "Цвет"
        label.setFootnoteFont()
        return label
    }()
    
    let colorPickerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "myOrange")
        button.addTarget(self, action: #selector(showColorPicker), for: .touchUpInside)
        return button
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Время"
        label.setFootnoteFont()
        return label
    }()
    
    private lazy var colorPicker: UIColorPickerViewController = {
        let cp = UIColorPickerViewController()
        cp.delegate = self
        return cp
    }()
    
    let chooseTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Каждый день в"
        label.setBodyFont()
        return label
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.addTarget(self, action: #selector(datePickerValue(_:)), for: .valueChanged)
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(views: [titleLabel, titleInput, colorLabel, colorPickerButton, timeLabel, chooseTimeLabel, datePicker])
        view.disableAutoresizingMask(views: [titleLabel, titleInput, colorLabel, colorPickerButton, timeLabel, chooseTimeLabel, datePicker])
        setupConstraints()
        setupDatePicker()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        colorPickerButton.layer.cornerRadius = colorPickerButton.frame.height / 2
    }
    
    @objc func showColorPicker() {
        self.present(colorPicker, animated: true, completion: nil)
    }
    
    // MARK: Setup Constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            titleInput.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            titleInput.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            titleInput.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            colorLabel.topAnchor.constraint(equalTo: titleInput.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            colorLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            colorPickerButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorPickerButton.widthAnchor.constraint(equalToConstant: 30),
            colorPickerButton.heightAnchor.constraint(equalToConstant: 30),
            colorPickerButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: colorPickerButton.bottomAnchor, constant: 15),
            timeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            chooseTimeLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
            chooseTimeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            chooseTimeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            datePicker.topAnchor.constraint(equalTo: chooseTimeLabel.bottomAnchor, constant: 15),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    func setupDatePicker() {
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
    }
    @objc func datePickerValue(_ sender: UIDatePicker) {
        print(datePicker.date)
    }
}


extension HabitViewController: UIColorPickerViewControllerDelegate {
    //  Called on every color selection done in the picker.
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
            colorPickerButton.backgroundColor = viewController.selectedColor
    }
}
