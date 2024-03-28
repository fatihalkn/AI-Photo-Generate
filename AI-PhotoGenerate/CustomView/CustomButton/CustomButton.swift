//
//  CustomButton.swift
//  TextToPhoto
//
//  Created by Fatih on 18.03.2024.
//

import Foundation
import UIKit

import UIKit

class CustomButtons: UIButton {
    private var gradientLayer: CAGradientLayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = bounds
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }

    convenience init(title: String? = nil, titleColor: UIColor? = nil, font: UIFont? = nil, backroundColor: UIColor? = nil, image: UIImage? = nil, borderWidth: CGFloat? = nil, borderColor: UIColor? = nil, gradientColors: [CGColor]? = nil) {
        self.init(frame: .zero)
        set(title: title, titleColor: titleColor, font: font, backroundColor: backroundColor, image: image, borderWidth: borderWidth, borderColor: borderColor)
        setupGradient()
        if let colors = gradientColors {
            applyGradient(colors: colors)
        }
    }

    private func setupGradient() {
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = bounds
        gradientLayer?.cornerRadius = layer.cornerRadius
        layer.insertSublayer(gradientLayer!, at: 0)
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.clear.cgColor
    }

    private func applyGradient(colors: [CGColor]) {
        gradientLayer?.colors = colors
        gradientLayer?.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer?.endPoint = CGPoint(x: 1, y: 1)
    }

   

    private func set(title: String? = nil, titleColor: UIColor? = nil, font: UIFont? = nil, backroundColor: UIColor? = nil, image: UIImage? = nil, borderWidth: CGFloat? = nil, borderColor: UIColor? = nil) {
        if let title = title {
            setTitle(title, for: .normal)
        }
        
        if let titleColor = titleColor {
            setTitleColor(titleColor, for: .normal)
        }
        
        if let font = font {
            titleLabel?.font = font
        }
        
        if let backroundColor = backroundColor {
            self.backgroundColor = backroundColor
        }
        
        if let image = image {
            setImage(image, for: .normal)
        }
        
        if let borderWidth = borderWidth {
            self.layer.borderWidth = borderWidth
        }
        
        if let borderColor = borderColor {
            self.layer.borderColor = borderColor.cgColor
        }
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
