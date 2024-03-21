//
//  Shake.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 21.03.2024.
//

import Foundation
import UIKit

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-10, 10, -10, 10, -5, 5, -2, 2, 0]
        layer.add(animation, forKey: "shake")
    }
}
