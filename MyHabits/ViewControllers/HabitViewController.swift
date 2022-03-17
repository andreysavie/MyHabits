//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Андрей Рыбалкин on 10.03.2022.
//

import UIKit


class HabitViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: PROPERTIES ============================================================================
    
    var habit: Habit?
    var habitName: String = ""
    
    let rightBarButtonItem = UIBarButtonItem(
       title: "Сохранить",
       style: .plain ,
       target: self,
       action: #selector(saveHabit)
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
        label.text = dateformat.string(from: timePicker.date)
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
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.isEnabled = true
        textField.addTarget(self, action: #selector(saveButtonEnable), for: .editingChanged)
        return textField
    }()
    
    //MARK: Set habit color
    private lazy var habitColorPicker: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.backgroundColor = UIColor.randomColor
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
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
        return button
    }()
    
    // MARK: INITIALIZATORS ============================================================================
    
    init(_ habitForEditing: Habit?) {
        super.init(nibName: nil, bundle: nil)
        habit = habitForEditing
        if let habitSource = habit {
            habitNameTextField.text = habitSource.name
            habitColorPicker.backgroundColor = habitSource.color
            date = habitSource.date
            deleteHabitButton.isHidden = false
        } else {
            deleteHabitButton.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habitNameTextField.delegate = self
        title = "Создать"
        view.backgroundColor = .white
        
        let leftBarButtonItem = UIBarButtonItem(
            title: "Отменить",
            style: .plain,
            target: self,
            action: #selector(cancelHabit)
        )
                
        leftBarButtonItem.tintColor = Colors.purpleColor
        leftBarButtonItem.isEnabled = true
        navigationItem.leftBarButtonItem = leftBarButtonItem
        rightBarButtonItem.tintColor = Colors.purpleColor
        rightBarButtonItem.isEnabled = true
        navigationItem.rightBarButtonItem = rightBarButtonItem
        setupContent()
        saveButtonEnable()
        
        if let habit = habit {
            setConfigureOfViewController(habit: habit)
        }
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK:  MAIN METHODS ============================================================================
    
    public func setConfigureOfViewController (habit: Habit) {
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
    
    @objc func saveHabit() {
        print ("Кнопка работает!!!")
        if let currentHabit = habit {
            currentHabit.name = habitNameTextField.text ?? "unknown"
            currentHabit.date = timePicker.date
            currentHabit.color = habitColorPicker.backgroundColor ?? Colors.purpleColor
            HabitsStore.shared.save()
            HabitsViewController.collectionView.reloadData()
        } else {
            let newHabit = Habit(name: habitNameTextField.text ?? "unknown",
                                 date: timePicker.date,
                                 color: habitColorPicker.backgroundColor ?? Colors.purpleColor)
            if HabitsStore.shared.habits.contains(newHabit) == false {
                HabitsStore.shared.habits.append(newHabit)
                HabitsViewController.collectionView.reloadData()
            }
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func removeHabit(sender: UIButton!) {
        let name = habit?.name ?? "unknown"
        let alertController = UIAlertController(
            title: "Удалить привычку",
            message: "Вы хотите удалить привычку \(name)?",
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
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            habitContentView.topAnchor.constraint(equalTo: habitScrollView.topAnchor),
            habitContentView.bottomAnchor.constraint(equalTo: habitScrollView.bottomAnchor),
            habitContentView.leadingAnchor.constraint(equalTo: habitScrollView.leadingAnchor),
            habitContentView.trailingAnchor.constraint(equalTo: habitScrollView.trailingAnchor),
            habitContentView.centerXAnchor.constraint(equalTo: habitScrollView.centerXAnchor),
            habitContentView.centerYAnchor.constraint(equalTo: habitScrollView.centerYAnchor),
            
            habitNameTitleLabel.topAnchor.constraint(equalTo: habitContentView.topAnchor, constant: Constants.leadingMargin),
            habitNameTitleLabel.leadingAnchor.constraint(equalTo: habitContentView.leadingAnchor, constant: Constants.leadingMargin),
            
            habitNameTextField.topAnchor.constraint(equalTo: habitNameTitleLabel.bottomAnchor, constant: Constants.inset),
            habitNameTextField.leadingAnchor.constraint(equalTo: habitContentView.leadingAnchor, constant: Constants.leadingMargin),
            habitNameTextField.trailingAnchor.constraint(equalTo: habitContentView.trailingAnchor, constant: Constants.trailingMargin),
            
            habitColorTitleLabel.topAnchor.constraint(equalTo: habitNameTextField.bottomAnchor, constant: Constants.leadingMargin),
            habitColorTitleLabel.leadingAnchor.constraint(equalTo: habitContentView.leadingAnchor, constant: Constants.leadingMargin),
            
            habitColorPicker.topAnchor.constraint(equalTo: habitColorTitleLabel.bottomAnchor, constant: Constants.inset),
            habitColorPicker.leadingAnchor.constraint(equalTo: habitContentView.leadingAnchor, constant: Constants.leadingMargin),
            habitColorPicker.widthAnchor.constraint(equalToConstant: Constants.colorPickerSide),
            habitColorPicker.heightAnchor.constraint(equalToConstant: Constants.colorPickerSide),
            
            habitTimeTitleLabel.topAnchor.constraint(equalTo: habitColorPicker.bottomAnchor, constant: Constants.leadingMargin),
            habitTimeTitleLabel.leadingAnchor.constraint(equalTo: habitContentView.leadingAnchor, constant: Constants.leadingMargin),
            
            habitSelectedTime.topAnchor.constraint(equalTo: habitTimeTitleLabel.bottomAnchor, constant: Constants.inset),
            habitSelectedTime.leadingAnchor.constraint(equalTo: habitContentView.leadingAnchor, constant: Constants.leadingMargin),
            
            dateValue.topAnchor.constraint(equalTo: habitTimeTitleLabel.bottomAnchor, constant: Constants.inset),
            dateValue.leadingAnchor.constraint(equalTo: habitSelectedTime.trailingAnchor, constant: Constants.inset),
            
            timePicker.topAnchor.constraint(equalTo: habitSelectedTime.bottomAnchor, constant: Constants.leadingMargin),
            timePicker.leadingAnchor.constraint(equalTo: habitContentView.leadingAnchor, constant: Constants.leadingMargin),
            timePicker.trailingAnchor.constraint(equalTo: habitContentView.trailingAnchor, constant: Constants.trailingMargin),
            timePicker.heightAnchor.constraint(equalToConstant: Constants.heightOfTimePicker),
            
            deleteHabitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.trailingMargin),
            deleteHabitButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            
        ])
    }
    
    // MARK: accesorry methods ==================================================
    
    private func habitLabel(_ title: String) -> UILabel {
        let label = UILabel()
        label.toAutoLayout()
        label.text = title
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.numberOfLines = 1
        return label
    }
    
    private func equotable() -> Bool {
        return habit?.name == habitNameTextField.text &&
        habit?.color == habitColorPicker.backgroundColor &&
        habit?.date == timePicker.date
    }

    @objc func saveButtonEnable() {
        if habitNameTextField.text?.isEmpty == true || equotable() == true {
            rightBarButtonItem.isEnabled = false
        } else {
            rightBarButtonItem.isEnabled = true
        }
    }
    
    @objc func timeChanged () {
        view.layoutIfNeeded()
        saveButtonEnable()
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
   
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
//MARK: EXTENSION for Color Picker

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        habitColorPicker.backgroundColor = viewController.selectedColor
        saveButtonEnable()
    }
}