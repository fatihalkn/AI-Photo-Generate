//
//  NavigationBar.swift
//  TextToPhoto
//
//  Created by Fatih on 18.03.2024.
//

import Foundation
import UIKit

extension UIViewController {    
    func configureItems(leftTitle: String,rightTitle: String ,rightButtonİmageFirst: UIImage, rightBarButtonİmageSecont: UIImage) {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = UIColor.white.withAlphaComponent(0.5)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    
        
        let rightSettingsButton = UIBarButtonItem(image: rightButtonİmageFirst,
                                                  style: .done,
                                                  target: self,
                                                  action: nil)
        let proRightBarButton = CustomButtons(title: rightTitle,
                                              titleColor: .rgb,
                                              font: .systemFont(ofSize: 18, weight: .bold),
                                              backroundColor: .clear,
                                              image: rightBarButtonİmageSecont)
        let rightProButton = UIBarButtonItem(customView: proRightBarButton)
        let rightBarButtons = [rightSettingsButton, rightProButton]
        navigationItem.rightBarButtonItems = rightBarButtons
        let creatNavigationLeftItem = CustomButtons(title: leftTitle,
                                                    titleColor: .white,
                                                    font: .systemFont(ofSize: 30, weight: .bold),
                                                    backroundColor: .clear)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: creatNavigationLeftItem)
        
        
    }
    
    
}
