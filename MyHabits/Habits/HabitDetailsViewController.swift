//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Андрей Рыбалкин on 10.03.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    private let myArray: NSArray = ["Andrey", "Ivan", "Sergey", "Ruslan", "Asif", "John", "Anna", "Greg", "Julia 💛"]
    
// 1. создаем экземпляр класса tableView:
    
    private var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
// 2. присвоим значение класса:
        
        myTableView = UITableView()
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        
// 3. зарегстрируем ячейки и зададим инициализатор, добавим на текущий view:
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self   //подпишем под протоколы
        myTableView.delegate = self     //подпишем под протоколы

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
    
    // Создадим Header для секции:
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность"
    }
    
    // Создадим Footer для секции:
//
//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        return "Footer 1"
//    }
    
    //MARK: создадим ячейку, укажем содержимое
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(myArray[indexPath.row])"
        return cell
    }
    //MARK: зададим действие при нажатии на ячейку: вывод адреса и имени ячейки.

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Num: \(indexPath.row)")
//        print("Value: \(myArray[indexPath.row])")
        
    //MARK: доп.функция: добавляет снятие выделения после прекращения нажатия на ячейку (deselect).
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: укажем количество ячеек в группе.

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
}
extension HabitDetailsViewController: UITableViewDelegate {}

