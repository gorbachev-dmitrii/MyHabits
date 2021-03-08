//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Dima Gorbachev on 16.02.2021.
//

import UIKit

class HabitViewController: UIViewController {
    // MARK: Properties
    let store = HabitsStore.shared
    var habit: Habit? {
        didSet {
            titleInput.text = habit?.name
            colorPickerButton.backgroundColor = habit?.color
            datePicker.date = habit?.date ?? Date()
            chooseTimeLabel.attributedText = createAttrString(fromDate: datePicker.date)
        }
    }
    //weak var delegate: ReloadDataDelegate?
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
        let picker = UIColorPickerViewController()
        picker.delegate = self
        return picker
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
    let removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        return button
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(views: [titleLabel, titleInput, colorLabel, colorPickerButton, timeLabel, chooseTimeLabel, datePicker, removeButton])
        view.disableAutoresizingMask(views: [titleLabel, titleInput, colorLabel, colorPickerButton, timeLabel, chooseTimeLabel, datePicker, removeButton])
        setupConstraints()
        setupDatePicker()
        configureNavigationBar()
        configureEditMode()
        view.backgroundColor = .white
    }
    @objc func closeModal() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureEditMode() {
        if let _ = habit {
            // макет для редактирования
            removeButton.isHidden = false
            titleInput.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            titleInput.textColor = UIColor(named: "myBlue")
            navigationItem.title = "Править"
        } else {
            // макет для создания
            removeButton.isHidden = true
            navigationItem.title = "Создать"
        }
    }
    
    @objc func showAlert() {
        let alertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \(habit!.name)?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) 
        let confirmAction = UIAlertAction(title: "Удалить", style: .default) { (action:UIAlertAction) in
            self.removeHabit()
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)

    }
    // MARK: Save/remove habit functions
    func removeHabit() {
        store.habits.removeAll(where: {$0 == self.habit})
        postReloadMessage()
        postToRootMessage()
    }
    
    
    @objc func saveHabit() {
        if let _ = habit {
            saveEditedHabit()
        } else {
            saveNewHabit()
        }
        //self.delegate?.reloadData()
        self.dismiss(animated: true, completion: {
            postReloadMessage()
        })
    }
    
    func saveNewHabit() {
            let newHabit = Habit(name: titleInput.text!,
                                 date: datePicker.date,
                                 color: colorPickerButton.backgroundColor!)
            store.habits.append(newHabit)
    }
    func saveEditedHabit() {
            habit?.color = colorPickerButton.backgroundColor!
            habit?.date = datePicker.date
            habit?.name = titleInput.text!
            postToRootMessage()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        colorPickerButton.layer.cornerRadius = colorPickerButton.frame.height / 2
    }
    
    func configureNavigationBar() {
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
        chooseTimeLabel.attributedText = createAttrString(fromDate: datePicker.date)
    }
    
    // MARK: Constraints
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
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            removeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            removeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func createAttrString(fromDate: Date) -> NSAttributedString {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "myPurple")]
        let attrString = NSMutableAttributedString(string: dateFormatter.string(from: fromDate), attributes: attributes as [NSAttributedString.Key : Any])
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
