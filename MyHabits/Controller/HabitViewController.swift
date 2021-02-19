//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Dima Gorbachev on 16.02.2021.
//

import UIKit

class HabitViewController: UIViewController {
    // MARK: Properties
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Название"
        label.setFootnoteFontUppercased()
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
        label.setFootnoteFontUppercased()
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
        label.setFootnoteFontUppercased()
        return label
    }()
    
    lazy var colorPicker: UIColorPickerViewController = {
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
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(views: [titleLabel, titleInput, colorLabel, colorPickerButton, timeLabel, chooseTimeLabel, datePicker])
        view.disableAutoresizingMask(views: [titleLabel, titleInput, colorLabel, colorPickerButton, timeLabel, chooseTimeLabel, datePicker])
        setupConstraints()
        setupDatePicker()
        configureNavigationButtons()
    }
    @objc func closeModal() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveHabit() {
        if let text = titleInput.text, let color = colorPickerButton.backgroundColor {
            let newHabit = Habit(name: text,
                                 date: datePicker.date,
                                 color: color)
            let store = HabitsStore.shared
            store.habits.append(newHabit)
            self.dismiss(animated: true, completion: nil)
        } else {
            print("при сохранении ошибка")
        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        colorPickerButton.layer.cornerRadius = colorPickerButton.frame.height / 2
    }
    
    func configureNavigationButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(closeModal))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "myPurple")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveHabit))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "myPurple")
    }
    
    // MARK: Date and Color Picker
    @objc func showColorPicker() {
        self.present(colorPicker, animated: true, completion: nil)
    }
    
    func setupDatePicker() {
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
    }
    
    @objc func datePickerValue(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        chooseTimeLabel.attributedText = createAttrString(fromString: dateFormatter.string(from: datePicker.date))
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
    
    func createAttrString(fromString: String) -> NSAttributedString {
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "myPurple")]
        let attrString = NSMutableAttributedString(string: fromString, attributes: attributes as [NSAttributedString.Key : Any])
        let normalStr = NSMutableAttributedString(string: "Каждый день в ")
        normalStr.append(attrString)
        return normalStr
    }
}
// MARK: UIColorPickerViewControllerDelegate
extension HabitViewController: UIColorPickerViewControllerDelegate {
    //  Called on every color selection done in the picker.
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
            colorPickerButton.backgroundColor = viewController.selectedColor
    }
}
