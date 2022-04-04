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
    var habitCheckerAction: (()->())?
        
    private lazy var habitNameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.headlineFont
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var habitSelectedTimeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textAlignment = .left
        label.textColor = .systemGray2
        label.font = Fonts.captionFont
        return label
    }()
    
    private lazy var habitCounter: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textAlignment = .left
        label.textColor = .systemGray
        label.font = Fonts.footnoteFont
        return label
    }()
    lazy var checker: UIButton = {
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
            
            habitNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            habitNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
             
            habitSelectedTimeLabel.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: 4),
            habitSelectedTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
             
             checker.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
             checker.leadingAnchor.constraint(equalTo: habitNameLabel.trailingAnchor, constant: 40),
             checker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
             checker.widthAnchor.constraint(equalToConstant: 36),
             checker.heightAnchor.constraint(equalToConstant: 36),
             
            habitCounter.topAnchor.constraint(equalTo: checker.bottomAnchor, constant: 20),
            habitCounter.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            habitCounter.trailingAnchor.constraint(equalTo: checker.leadingAnchor, constant: -40)

        ])
    }
    
    @objc func tapOnChecker() {
        guard let trackedHabit = habit else { return }
        HabitsStore.shared.track(trackedHabit)
        habitCheckerAction?()
    }
}
