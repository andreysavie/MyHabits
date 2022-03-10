//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Андрей Рыбалкин on 10.03.2022.
//

import UIKit

class InfoViewController: UIViewController {


    
    private lazy var infoScrollView: UIScrollView = {
        let scrollVIew = UIScrollView()
        scrollVIew.toAutoLayout()
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

//        textView.isScrollEnabled = true
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContentViews()
    }

    private func setupContentViews() {

        view.addSubview(infoScrollView)
        infoScrollView.addSubview(contentView)
        contentView.addSubviews(informationTitle, informationTextView)
        setupConstraints()
        self.loadViewIfNeeded()
    }
    

    private func setupConstraints() {
        NSLayoutConstraint.activate([
        
            infoScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            infoScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            infoScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: infoScrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: infoScrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: infoScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: infoScrollView.trailingAnchor),
            contentView.centerXAnchor.constraint(equalTo: infoScrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: infoScrollView.centerYAnchor),

            informationTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            informationTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            informationTextView.topAnchor.constraint(equalTo: informationTitle.bottomAnchor, constant: 22),
            informationTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            informationTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            informationTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)


        ])
    }

}
