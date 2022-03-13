//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Андрей Рыбалкин on 10.03.2022.
//

import UIKit

class HabitsViewController: UIViewController {
    
    let store = HabitsStore.shared
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 22, left: 0, bottom: 0, right: 0)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = Colors.lightGrayColor
        collection.toAutoLayout()
        collection.dataSource = self
        collection.delegate = self
        collection.register(
            HabitCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: HabitCollectionViewCell.self))
        collection.register(
            ProgressCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: ProgressCollectionViewCell.self))
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain ,
            target: self,
            action: #selector(addNewHabbit))
        
        rightBarButtonItem.tintColor = Colors.purpleColor
        navigationItem.rightBarButtonItem = rightBarButtonItem
        setupContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    private func setupContent() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func addNewHabbit() {
        let habitViewCintroller = HabitViewController()
        navigationController?.pushViewController(habitViewCintroller, animated: true)
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var sectionsCount = 0
        switch section {
        case 0:
            sectionsCount = 1
        case 1:
            sectionsCount = store.habits.count
        default:
            break
        }
        return sectionsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as? ProgressCollectionViewCell else { return UICollectionViewCell() }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as? HabitCollectionViewCell else { return UICollectionViewCell() }
            cell.setConfigureOfCell(habit: store.habits[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 0
        switch indexPath.section {
        case 0:
            height = 60
        case 1:
            height = 130
        default:
            break
        }
        return CGSize(width: floor(collectionView.frame.width - 32), height: height)
    }
}
