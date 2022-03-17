//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Андрей Рыбалкин on 13.03.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    // MARK: PROPERTIES ============================================================================

    var habit: Habit?
    
    private lazy var habitNameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private lazy var habitSelectedTimeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textAlignment = .left
        label.textColor = .systemGray2
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var habitCounter: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textAlignment = .left
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    private lazy var checker: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setImage(UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
        button.tintColor = .green
        button.addTarget(self, action: #selector(tapOnChecker), for: .touchUpInside)
        return button
    }()
    
    // MARK: INITIALIZATORS ============================================================================

    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.addSubviews(habitNameLabel, habitSelectedTimeLabel, habitCounter, checker)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS ===================================================================================

    public func setConfigureOfCell(habit: Habit) {
        self.habit = habit
        habitNameLabel.text = habit.name
        habitNameLabel.textColor = habit.color
        habitSelectedTimeLabel.text = habit.dateString
        checker.tintColor = habit.color
        habitCounter.text = "Счётчик: " + String(habit.trackDates.count)
        
        if habit.isAlreadyTakenToday == true {
            checker.setImage(UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
            checker.isUserInteractionEnabled = false
        } else {
            self.checker.setImage(UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
            checker.isUserInteractionEnabled = true
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            habitNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            habitNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            
            habitSelectedTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            habitSelectedTimeLabel.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: 4),
            
            habitCounter.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            habitCounter.topAnchor.constraint(equalTo: habitSelectedTimeLabel.bottomAnchor, constant: 30),
            
            checker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            checker.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checker.widthAnchor.constraint(equalToConstant: 36),
            checker.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    @objc func tapOnChecker() {
        guard let trackedHabit = habit else { return }
            HabitsStore.shared.track(trackedHabit)
            HabitsViewController.collectionView.reloadData()
        }
}
