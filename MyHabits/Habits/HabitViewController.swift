//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Андрей Рыбалкин on 10.03.2022.
//

import UIKit


class HabitViewController: UIViewController, UITextFieldDelegate{
    
    // MARK: PROPERTIES ============================================================================

    var habit: Habit?
    
    private let rightBarButtonItem = UIBarButtonItem(
        title: "Сохранить",
        style: .plain ,
        target: self,
        action: #selector(saveNewHabbit)
    )
    
    private var date: Date = Date() {
        didSet {
            let dateformat = DateFormatter()
            dateformat.dateFormat = "HH:mm a"
            dateValue.text = dateformat.string(from: date)
        }
    }
    //MARK: LABELS
    private lazy var habitNameTitleLabel = habitLabel("НАЗВАНИЕ")
    private lazy var habitColorTitleLabel = habitLabel("ЦВЕТ")
    private lazy var habitTimeTitleLabel = habitLabel("ВРЕМЯ")
    
    private lazy var habitScrollView: UIScrollView = {
        let scrollVIew = UIScrollView(frame: self.view.bounds)
        scrollVIew.isScrollEnabled = false
        return scrollVIew
    }()
    
    private lazy var habitContentView: UIView = {
        let contentView = UIView()
        contentView.toAutoLayout()
        return contentView
    }()
    
    
    //MARK: Selected time label
    private lazy var habitSelectedTime: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Каждый день в"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private lazy var dateValue: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        let dateformat = DateFormatter()
        dateformat.dateFormat = "HH:mm a"
        label.text = dateformat.string(from: date)
        return label
    }()
    
    //MARK: Set habit name textFIeld
    private lazy var habitNameTextField: UITextField = {
        let textField = UITextField()
        textField.toAutoLayout()
        textField.backgroundColor = .clear
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.textColor = .black
        textField.autocorrectionType = UITextAutocorrectionType.yes
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing // изменить название кнопки на "готово"
        textField.isEnabled = true
        textField.isUserInteractionEnabled = true
        textField.addTarget(self, action: #selector(saveButtonEnabled), for: .editingChanged)
        return textField
    }()
    
    //MARK: Set habit color
    private lazy var habitColorPicker: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.backgroundColor = UIColor.green // сделать рандомный выбор
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.addTarget(self, action: #selector(openColorPickerViewController), for: .touchUpInside)
        return button
    }()
    
    private lazy var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.toAutoLayout()
        timePicker.date = date
        timePicker.backgroundColor = .white.withAlphaComponent(0.9)
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        return timePicker
    }()
    
    private lazy var deleteHabitButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.backgroundColor = .clear
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(removeHabit), for: .touchUpInside)
//        button.isHidden = true
        return button
    }()
    
    // MARK: INITIALIZATORS ============================================================================
    
//    init(habitName: String, habitColor: UIColor, habitTime: Date) {
//        super.init(nibName: nil, bundle: nil)
//
//        self.habitNameTextField.text = habitName
//        self.habitColorPicker.backgroundColor = habitColor
//        self.habitSelectedTime.text = habit?.dateString
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Создать"
        view.backgroundColor = .white
        
        let leftBarButtonItem = UIBarButtonItem(
            title: "Отменить",
            style: .plain ,
            target: self,
            action: #selector(cancelHabit)
        )
        leftBarButtonItem.tintColor = Colors.purpleColor
        leftBarButtonItem.isEnabled = true
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        rightBarButtonItem.tintColor = Colors.purpleColor
        rightBarButtonItem.isEnabled = false
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        setupContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: METHODS ============================================================================
    
    // ТЕСТ!!!
    public func setConfigureOfViewController(habit: Habit) {
        self.habit = habit
        self.habitNameTextField.text = habit.name
        self.habitColorPicker.backgroundColor = habit.color
        self.date = habit.date
        self.habitSelectedTime.text = "Каждый день в "
        self.timePicker.date = habit.date
    }
    
    private func setupContent() {
        view.addSubview(habitScrollView)
        habitScrollView.addSubview(habitContentView)
        habitScrollView.contentSize = self.habitContentView.bounds.size
        habitContentView.addSubviews(habitNameTitleLabel, habitNameTextField, habitColorTitleLabel, habitColorPicker, habitTimeTitleLabel, habitSelectedTime, dateValue, timePicker, deleteHabitButton)
        setupConstraints()
        self.loadViewIfNeeded()
    }
    
    private func habitLabel(_ title: String) -> UILabel {
        let label = UILabel()
        label.toAutoLayout()
        label.text = title
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.numberOfLines = 1
        return label
    }
    
    @objc func timeChanged () {
        self.view.layoutIfNeeded()
    }
    
    @objc func saveNewHabbit () {
        let newHabit = Habit(name: habitNameTextField.text ?? "",
                             date: timePicker.date,
                             color: habitColorPicker.backgroundColor ?? .green)
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func removeHabit(sender: UIButton!) {
        
        let alertController = UIAlertController(
            title: "Удалить привычку",
            message: "Вы хотите удалить привычку (привычка)?",
            preferredStyle: .alert)
        
        let acceptAction = UIAlertAction(title: "Отмена", style: .default) { (_) -> Void in }
        let declineAction = UIAlertAction(title: "Удалить", style: .destructive) { (_) -> Void in
            if let removingHabit = self.habit {
                HabitsStore.shared.habits.removeAll(where: {$0 == removingHabit})
                HabitsViewController.collectionView.reloadData()
            }
            self.navigationController?.popToRootViewController(animated: true)
        }
        alertController.addAction(acceptAction)
        alertController.addAction(declineAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func cancelHabit () {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func openColorPickerViewController() {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func saveButtonEnabled() {
        if habitNameTextField.text?.isEmpty == true {
            rightBarButtonItem.isEnabled = false
        } else {
            rightBarButtonItem.isEnabled = true
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            habitContentView.topAnchor.constraint(equalTo: habitScrollView.topAnchor),
            habitContentView.bottomAnchor.constraint(equalTo: habitScrollView.bottomAnchor),
            habitContentView.leadingAnchor.constraint(equalTo: habitScrollView.leadingAnchor),
            habitContentView.trailingAnchor.constraint(equalTo: habitScrollView.trailingAnchor),
            habitContentView.centerXAnchor.constraint(equalTo: habitScrollView.centerXAnchor),
            habitContentView.centerYAnchor.constraint(equalTo: habitScrollView.centerYAnchor),
            
            habitNameTitleLabel.topAnchor.constraint(equalTo: habitContentView.topAnchor, constant: 16),
            habitNameTitleLabel.leadingAnchor.constraint(equalTo: habitContentView.leadingAnchor, constant: 16),
            
            habitNameTextField.topAnchor.constraint(equalTo: habitNameTitleLabel.bottomAnchor, constant: 8),
            habitNameTextField.leadingAnchor.constraint(equalTo: habitContentView.leadingAnchor, constant: 16),
            habitNameTextField.trailingAnchor.constraint(equalTo: habitContentView.trailingAnchor, constant: -16),
            
            habitColorTitleLabel.topAnchor.constraint(equalTo: habitNameTextField.bottomAnchor, constant: 16),
            habitColorTitleLabel.leadingAnchor.constraint(equalTo: habitContentView.leadingAnchor, constant: 16),
            
            habitColorPicker.topAnchor.constraint(equalTo: habitColorTitleLabel.bottomAnchor, constant: 8),
            habitColorPicker.leadingAnchor.constraint(equalTo: habitContentView.leadingAnchor, constant: 16),
            habitColorPicker.widthAnchor.constraint(equalToConstant: 30),
            habitColorPicker.heightAnchor.constraint(equalToConstant: 30),
            
            habitTimeTitleLabel.topAnchor.constraint(equalTo: habitColorPicker.bottomAnchor, constant: 16),
            habitTimeTitleLabel.leadingAnchor.constraint(equalTo: habitContentView.leadingAnchor, constant: 16),
            
            habitSelectedTime.topAnchor.constraint(equalTo: habitTimeTitleLabel.bottomAnchor, constant: 8),
            habitSelectedTime.leadingAnchor.constraint(equalTo: habitContentView.leadingAnchor, constant: 16),
            
            dateValue.topAnchor.constraint(equalTo: habitTimeTitleLabel.bottomAnchor, constant: 8),
            dateValue.leadingAnchor.constraint(equalTo: habitSelectedTime.trailingAnchor, constant: 8),
            
            timePicker.topAnchor.constraint(equalTo: habitSelectedTime.bottomAnchor, constant: 16),
            timePicker.leadingAnchor.constraint(equalTo: habitContentView.leadingAnchor, constant: 16),
            timePicker.trailingAnchor.constraint(equalTo: habitContentView.trailingAnchor, constant: -16),
            timePicker.heightAnchor.constraint(equalToConstant: 200),
            
            deleteHabitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            deleteHabitButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            
        ])
    }
}

//MARK: EXTENSION for Color Picker

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        habitColorPicker.backgroundColor = viewController.selectedColor
    }
}
