//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Андрей Рыбалкин on 10.03.2022.
//

import UIKit

class HabitsViewController: UIViewController {
    
    // MARK: PROPERTIES ============================================================================
    
    var habit: Habit?
    
    static var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Constants.indent
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: Constants.topSectionInset, left: 0, bottom: 0, right: 0)
        return layout
    }()
    
    static var collectionView: UICollectionView = {
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: HabitsViewController.layout
        )
        collection.backgroundColor = Colors.lightGrayColor
        collection.toAutoLayout()
        collection.register(
            HabitCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: HabitCollectionViewCell.self))
        collection.register(
            ProgressCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: ProgressCollectionViewCell.self))
        return collection
    }()
   
    // MARK: INITIALIZATORS ============================================================================

    override func viewDidLoad() {
        super.viewDidLoad()
        let rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain ,
            target: self,
            action: #selector(addNewHabbit))
        rightBarButtonItem.tintColor = Colors.purpleColor
        navigationItem.rightBarButtonItem = rightBarButtonItem
        HabitsViewController.collectionView.dataSource = self
        HabitsViewController.collectionView.delegate = self
        setupContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        HabitsViewController.collectionView.reloadData()
    }

    // MARK: METHODS ===================================================================================

    private func setupContent() {
        view.addSubview(HabitsViewController.collectionView)
        NSLayoutConstraint.activate([
            HabitsViewController.collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            HabitsViewController.collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            HabitsViewController.collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            HabitsViewController.collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func addNewHabbit() {
        navigationController?.pushViewController(HabitViewController(nil), animated: true)
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
            sectionsCount = HabitsStore.shared.habits.count
        default:
            break
        }
        return sectionsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as? ProgressCollectionViewCell else { return UICollectionViewCell() }
            cell.setupContent()
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as? HabitCollectionViewCell else { return UICollectionViewCell() }
            cell.setConfigureOfCell(habit: HabitsStore.shared.habits[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard indexPath != [0,0] else { return }
            let habitDetailsViewController = HabitDetailsViewController(HabitsStore.shared.habits[indexPath.row])
            navigationController?.pushViewController(habitDetailsViewController, animated: true)
            collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 0
        switch indexPath.section {
        case 0:
            height = Constants.heightFor0Section
        case 1:
            height = Constants.heightFor1Section
        default:
            break
        }
        return CGSize(width: floor(collectionView.frame.width - 32), height: height)
    }
}
