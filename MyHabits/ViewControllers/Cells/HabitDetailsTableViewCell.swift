//
//  HabitDetailsTableViewCell.swift
//  MyHabits
//
//  Created by Андрей Рыбалкин on 15.03.2022.
//
//
import UIKit

class HabitDetailTableViewCell: UITableViewCell {
    
    // MARK: PROPERTIES ============================================================================

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.title3Font
        return label
    }()
    
    lazy var checker: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.title3Font
        label.textColor = Colors.purpleColor
        label.text = "✔︎"
        return label
    }()
    
    // MARK: INITIALIZATORS ============================================================================

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(dateLabel, checker)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS ===================================================================================

    func setupConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.indent),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.indent),
            checker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.indent),
            checker.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: Constants.leadingMargin),
            checker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMargin)
        ])
    }
    
    func setConfigureOfCell(index: Int, check: Bool) {      
        dateLabel.text = HabitsStore.shared.trackDateString(forIndex: index)
        checker.isHidden = !check
    }
}
