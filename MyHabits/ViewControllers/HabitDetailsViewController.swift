//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Андрей Рыбалкин on 10.03.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    // MARK: PROPERTIES ============================================================================

    let habit: Habit

    private lazy var rightBarButtonItem = setBarButton(title: "Править", action: #selector(editHabit))
    private lazy var leftBarButtonItem = setBarButton(title: "❮ Сегодня", action: #selector(tapToCancel))

    static let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped )
        table.toAutoLayout()
        table.separatorInset = .zero
        table.rowHeight = UITableView.automaticDimension
        table.refreshControl?.addTarget(self, action: #selector(updateTable), for: .valueChanged)
        table.refreshControl = UIRefreshControl()
        return table
    }()

    // MARK: INITIALIZATORS ============================================================================

    init(_ habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.lightGrayColor
        view.addSubview(HabitDetailsViewController.tableView)
        setupConstraints()
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
        HabitDetailsViewController.tableView.dataSource = self
        HabitDetailsViewController.tableView.delegate = self
        
        HabitDetailsViewController.tableView.register(
            HabitDetailTableViewCell.self,
            forCellReuseIdentifier: String(
                describing: HabitDetailTableViewCell.self)
        )
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = habit.name
    }

    // MARK: METHODS ===================================================================================

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            HabitDetailsViewController.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            HabitDetailsViewController.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            HabitDetailsViewController.tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            HabitDetailsViewController.tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    @objc func tapToCancel() {
        navigationController?.popViewController(animated: true)
    }

    @objc func editHabit() {
        navigationController?.pushViewController(HabitViewController(habit), animated: true)
    }

    @objc func updateTable() {
        HabitDetailsViewController.tableView.reloadData()
        HabitDetailsViewController.tableView.refreshControl?.endRefreshing()
    }
    
    private func setBarButton (title: String, action: Selector) -> UIBarButtonItem {
        let button = UIBarButtonItem  (
            title: title,
            style: .plain ,
            target: self,
            action: action
        )
        button.tintColor = Colors.purpleColor
        return button
    }
}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HabitDetailTableViewCell.self), for: indexPath) as? HabitDetailTableViewCell else { return UITableViewCell() }
        let date = HabitsStore.shared.dates[indexPath.row]
        cell.setConfigureOfCell(date: date, check: HabitsStore.shared.habit(habit, isTrackedIn: date))
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "  АКТИВНОСТЬ"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}