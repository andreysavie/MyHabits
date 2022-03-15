//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Андрей Рыбалкин on 10.03.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    // возможно не понадобится
    private var date: Date = Date() {
        didSet {
            let dateformat = DateFormatter()
            dateformat.dateFormat = "HH:mm a"
        }
    }
        
    private var myTableView: UITableView = {
        let tableView = UITableView()
        tableView.toAutoLayout()
        return tableView
    }()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.lightGrayColor
                            
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self

        self.view.addSubview(myTableView)
        
        setupConstraints()
    }
    
    func setupConstraints () {
        NSLayoutConstraint.activate([
            myTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            myTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            myTableView.topAnchor.constraint(equalTo: view.topAnchor),
            myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HabitDetailsViewController: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность"
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(HabitsStore.shared.dates[indexPath.row])"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
}
extension HabitDetailsViewController: UITableViewDelegate {}

