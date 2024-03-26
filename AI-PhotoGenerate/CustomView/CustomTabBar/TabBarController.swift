//
//  TabBarController.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 19.03.2024.
//

import Foundation
import UIKit

class TabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = .white
        self.tabBar.barTintColor = .main
        self.tabBar.unselectedItemTintColor = .darkGray
        setupTabs()
    }
    
    private func setupTabs() {
        let create = createNav(title: "Creat", image: .creat, vc: HomePageController())
        let myArt = createNav(title: "My Art", image: .art, vc: MyArt())
        let inspiration = createNav(title: "Inspiration", image: .ins, vc: InspirationController())
        self.setViewControllers([create,inspiration,myArt], animated: true)
    }
    private func createNav(title: String, image: UIImage, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
}
