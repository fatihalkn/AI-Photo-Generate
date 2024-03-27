//
//  TableViewHeader.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 26.03.2024.
//

import UIKit

class TableViewHeader: UIView {
    
    private let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Turn On Unlimited Access"
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let removeAdsLabel: UILabel = {
        let label = UILabel()
        label.text = "Remove All Ads"
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let unlimitedLabel: UILabel = {
        let label = UILabel()
        label.text = "Unlimited Art Creation"
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let unlimitedİmage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = .for
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let removeAdsİmage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = .ads
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
   
    
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = .header
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(headerImageView)
        addSubview(headerTitleLabel)
        addSubview(removeAdsLabel)
        addSubview(unlimitedLabel)
        addSubview(removeAdsİmage)
        addSubview(unlimitedİmage)
        setupCons()
        
    }
    
    func setImage(_ image: UIImage?) {
        headerImageView.image = image
    }
}

extension TableViewHeader {
    
    func setupCons() {
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            headerTitleLabel.topAnchor.constraint(equalTo:headerImageView.topAnchor,constant: 10),
            headerTitleLabel.leadingAnchor.constraint(equalTo: headerImageView.leadingAnchor,constant: 10),
            headerTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            unlimitedİmage.topAnchor.constraint(equalTo: headerTitleLabel.bottomAnchor,constant: 20),
            unlimitedİmage.leadingAnchor.constraint(equalTo: headerImageView.leadingAnchor,constant: 10),
            
            unlimitedLabel.topAnchor.constraint(equalTo: headerTitleLabel.bottomAnchor, constant: 25),
            unlimitedLabel.leadingAnchor.constraint(equalTo: unlimitedİmage.trailingAnchor,constant: 10),
            unlimitedLabel.heightAnchor.constraint(equalToConstant: 18),
            
            removeAdsİmage.topAnchor.constraint(equalTo: unlimitedİmage.bottomAnchor, constant: 20),
            removeAdsİmage.leadingAnchor.constraint(equalTo: headerImageView.leadingAnchor,constant: 10),
            
            removeAdsLabel.topAnchor.constraint(equalTo: unlimitedLabel.bottomAnchor, constant: 32),
            removeAdsLabel.leadingAnchor.constraint(equalTo: removeAdsİmage.trailingAnchor,constant: 10),
            removeAdsLabel.heightAnchor.constraint(equalToConstant: 18)

            

    
        ])
    }
}
