//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Андрей Рыбалкин on 10.03.2022.
//

import UIKit

class InfoViewController: UIViewController {

    private lazy var infoScrollView: UIScrollView = {
        let scrollVIew = UIScrollView(frame: self.view.bounds)
        return scrollVIew
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.toAutoLayout()
        return contentView
    }()
    
    private lazy var informationTitle: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Привычка за 21 день"
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var informationTextView: UITextView = {
        let textView = UITextView()
        textView.toAutoLayout()
        textView.text = InfoDescription.placeholder
        textView.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textView.textColor = .black
        textView.isScrollEnabled = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(infoScrollView)
        infoScrollView.addSubview(contentView)
        infoScrollView.contentSize = self.informationTextView.bounds.size
        contentView.addSubviews(informationTitle, informationTextView)
        setupConstraints()
        self.loadViewIfNeeded()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: infoScrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: infoScrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: infoScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: infoScrollView.trailingAnchor),
            contentView.centerXAnchor.constraint(equalTo: infoScrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: infoScrollView.centerYAnchor),
            
            informationTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            informationTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            informationTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            informationTitle.heightAnchor.constraint(equalToConstant: 40),

            informationTextView.topAnchor.constraint(equalTo: informationTitle.bottomAnchor),
            informationTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            informationTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            informationTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
