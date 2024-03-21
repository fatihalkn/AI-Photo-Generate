//
//  ProgresHud.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 20.03.2024.
//

import Foundation
//
//  ProgresHUDExtantion.swift
//  E-Commerce
//
//  Created by Fatih on 12.02.2024.
//

import Foundation
import ProgressHUD
import UIKit

extension UIViewController {
    func showLoading(text: String?, type: AnimationType = .circleStrokeSpin, interaction: Bool) {
        ProgressHUD.animate(text, type, interaction: interaction)
    }
    
    func removeLoading() {
        ProgressHUD.remove()
    }
    
    func showError(text: String?, image: UIImage?, interaction: Bool, delay: TimeInterval?) {
        ProgressHUD.error(text, image: image, interaction: interaction, delay: delay)
    }
    
    func showSucceed(text: String?, interaction: Bool, delay: TimeInterval?) {
        ProgressHUD.succeed(text, interaction: interaction, delay: delay)
    }
    

}
