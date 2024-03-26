//
//  CustomButton.swift
//  TextToPhoto
//
//  Created by Fatih on 18.03.2024.
//

import Foundation
import UIKit

class CustomButtons: UIButton {
    
    
    override init(frame: CGRect) {
        super .init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    convenience init(title: String? = nil, titleColor: UIColor? = nil, font: UIFont? = nil, backroundColor: UIColor? = nil, image: UIImage? = nil, borderWidth: CGFloat? = nil, borderColor: UIColor? = nil) {
        self.init(frame: .zero)
        set(title: title, titleColor: titleColor, font: font, backroundColor: backroundColor, image: image, borderWidth: borderWidth, borderColor: borderColor)
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
