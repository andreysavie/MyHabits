//
//  HabitsHeaderView.swift
//  MyHabits
//
//  Created by Андрей Рыбалкин on 10.03.2022.
//

import UIKit

class HabitsHeaderView: UITableViewHeaderFooterView {

    static let identifire = "HabitsHeaderView"

    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 44))?.withTintColor(Colors.purpleColor, renderingMode: .alwaysOriginal), for: .normal)
        button.backgroundColor = .clear
//        button.addTarget(self, action: #selector(), for: .touchUpInside)
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Сегодня"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        return label
    }()
 
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(titleLabel, addButton)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
//            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 92),

            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            addButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 44)
        ])
    }
    
    
    
    
    
    
    }

