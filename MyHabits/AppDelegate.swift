//
//  AppDelegate.swift
//  MyHabits
//
//  Created by Андрей Рыбалкин on 10.03.2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
    
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabBarController = UITabBarController()
                        
        let habitsViewController = HabitsViewController()
        habitsViewController.view.backgroundColor = .white
        let habitsNavigationController = UINavigationController(rootViewController: habitsViewController)
        
        let infoViewController = InfoViewController()
        infoViewController.view.backgroundColor = .white
        let infoNavigationController = UINavigationController(rootViewController: infoViewController)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Colors.navigationBarColor
                
        habitsNavigationController.tabBarItem = UITabBarItem(
            title: Labels.habitsTabBarTitle,
            image: UIImage(systemName: "rectangle.grid.1x2"),
            selectedImage: UIImage(systemName: "rectangle.grid.1x2.fill")
        )
        habitsNavigationController.tabBarItem.setTitleTextAttributes(attributes,for: .normal)
        habitsNavigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        habitsNavigationController.navigationBar.topItem?.title = Labels.habitsNavigationControllerTitle
        habitsNavigationController.navigationBar.barTintColor = Colors.navigationBarColor
        habitsNavigationController.navigationBar.standardAppearance = appearance
        habitsNavigationController.navigationBar.scrollEdgeAppearance = habitsNavigationController.navigationBar.standardAppearance
        
        infoNavigationController.tabBarItem = UITabBarItem(
            title: Labels.infoTabBarTitle,
            image: UIImage(systemName: "info.circle"),
            selectedImage: UIImage(systemName:"info.circle.fill")
        )
        infoNavigationController.tabBarItem.setTitleTextAttributes(attributes, for: .normal)
        infoNavigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        infoNavigationController.navigationBar.topItem?.title = Labels.infoNavigationControllerTitle
        infoNavigationController.navigationBar.barTintColor = Colors.navigationBarColor
        infoNavigationController.navigationBar.standardAppearance = appearance
        infoNavigationController.navigationBar.scrollEdgeAppearance = infoNavigationController.navigationBar.standardAppearance
        
        tabBarController.viewControllers = [habitsNavigationController, infoNavigationController]
        tabBarController.tabBar.backgroundColor = UIColor.systemGray5
                        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}

