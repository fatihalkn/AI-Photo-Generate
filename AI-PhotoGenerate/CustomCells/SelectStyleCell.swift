//
//  SelectStyleCell.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 19.03.2024.
//

import UIKit

class SelectStyleCell: UICollectionViewCell {
    static let identifier = "SelectStyleCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureCons()
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     let styleImageView: UIImageView = {
        let imageView = UIImageView()
         imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius  = 16
        return imageView
    }()
    
     let styleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .rgb
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupUI() {
        self.addSubview(styleImageView)
        self.addSubview(styleLabel)
    }
}

//MARK: - Configure Constrains
extension SelectStyleCell {
    
    func configureCons() {
        NSLayoutConstraint.activate([
            styleImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            styleImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            styleImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            styleImageView.heightAnchor.constraint(equalToConstant: 100),
            
            styleLabel.centerXAnchor.constraint(equalTo: styleImageView.centerXAnchor),
            styleLabel.topAnchor.constraint(equalTo: styleImageView.bottomAnchor),
            styleLabel.bottomAnchor.constraint(greaterThanOrEqualTo:self.safeAreaLayoutGuide.bottomAnchor),
            styleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            styleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
            
        ])
    }
}
