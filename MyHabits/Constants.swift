//
//  Constants.swift
//  MyHabits
//
//  Created by Андрей Рыбалкин on 10.03.2022.
//

import Foundation
import UIKit

public struct Colors {
    
    static let lightGrayColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
    static var purpleColor = UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 1)
    static let blueColor = UIColor(red: 41/255, green: 109/255, blue: 255/255, alpha: 1)
    static let greenColor = UIColor(red: 29/255, green: 179/255, blue: 34/255, alpha: 1)
    static let indigoColor = UIColor(red: 98/255, green: 54/255, blue: 255/255, alpha: 1)
    static let orangeColor = UIColor(red: 255/255, green: 159/255, blue: 79/255, alpha: 1)
    static let navigationBarColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 0.94)
    
}

public struct Labels {
    
    static let habitsNavigationControllerTitle = "Сегодня"
    static let infoNavigationControllerTitle = "Информация"
    
    static let habitsTabBarTitle = "Привычки"
    static let infoTabBarTitle = "Информация"
}

public struct InfoDescription {
        
    static let placeholder = "Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму: 1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага. \n\n2. Выдержать 2 дня в прежнем состоянии самоконтроля. \n\n3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться. \n\n4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств. \n\n5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой. \n\n6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся. \n\nИсточник: psychbook.ru"
}


public extension UIView {

    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ subviews: UIView...) {
          subviews.forEach { addSubview($0) }
      }
}
