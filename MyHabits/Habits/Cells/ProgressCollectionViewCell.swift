//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Андрей Рыбалкин on 13.03.2022.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
   
    private lazy var progressNameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textColor = .systemGray
        label.text = "Всё получится!"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)

        return label
    }()
    
    private lazy var progressProcentLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray
        label.text = "50%"

        return label
    }()

    
    private lazy var progressLine: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar )
        progress.toAutoLayout()
        progress.trackTintColor = .systemGray2
        progress.progressTintColor = Colors.purpleColor
        progress.backgroundColor = .white
        progress.layer.cornerRadius = 5
        progress.clipsToBounds = true
        progress.layer.sublayers![1].cornerRadius = 3
        progress.subviews[1].clipsToBounds = true
        return progress
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        setupContent()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContent() {
        contentView.addSubviews(progressNameLabel, progressProcentLabel, progressLine)
        progressLine.progress = HabitsStore.shared.todayProgress
        progressProcentLabel.text = String(Int(HabitsStore.shared.todayProgress * 100)) + "%"        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            progressNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            progressProcentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressProcentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),

            progressLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressLine.topAnchor.constraint(equalTo: progressNameLabel.bottomAnchor, constant: 10),
            progressLine.heightAnchor.constraint(equalToConstant: 7),
            
        ])
    }
}
