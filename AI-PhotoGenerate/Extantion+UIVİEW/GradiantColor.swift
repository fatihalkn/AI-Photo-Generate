//
//  GradiantColor.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 28.03.2024.
//

import Foundation
import QuartzCore
import UIKit

extension CAGradientLayer {
    enum Rainbow {
        static let colors: [CGColor] = [
            UIColor.red.cgColor,
            UIColor.orange.cgColor,
            UIColor.yellow.cgColor,
            UIColor.green.cgColor,
            UIColor.blue.cgColor,
            UIColor.purple.cgColor
        ]
    }
    
    func setRainbowBackground() {
        self.colors = Rainbow.colors
        self.startPoint = CGPoint(x: 0, y: 0)
        self.endPoint = CGPoint(x: 1, y: 1)
    }
}
