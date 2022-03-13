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
        label.textAlignment = .left
        label.textColor = .systemGray
        label.text = "Всё получится!"
        return label
    }()
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textAlignment = .left
        label.textColor = .black
        label.text = "50%"
        
        return label
    }()
    
    private lazy var progressLine: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar )
        progress.toAutoLayout()
        progress.trackTintColor = .white
        progress.progressTintColor = .systemPurple
        progress.backgroundColor = .white
        progress.layer.cornerRadius = 8
        progress.clipsToBounds = true
        progress.layer.sublayers![1].cornerRadius = 3
        progress.subviews[1].clipsToBounds = true
        return progress
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupConstraints()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        contentView.addSubview(progressNameLabel)
        contentView.addSubview(progressLabel)
        contentView.addSubview(progressLine)
        NSLayoutConstraint.activate([
            progressNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            progressLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressLine.topAnchor.constraint(equalTo: progressNameLabel.bottomAnchor, constant: 10),
            
            progressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
        ])
    }
}
