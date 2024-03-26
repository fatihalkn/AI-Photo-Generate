//
//  MyArtCell.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 25.03.2024.
//

import UIKit

protocol MyArtCellDelegate: AnyObject {
    func clickedButton(_ indexPath: IndexPath)
}

class MyArtCell: UICollectionViewCell {
    
    var myArtCellinterface: MyArtCellDelegate?
    static let identifier = "MyArtCell"
    var indexPath: IndexPath?
    
    let myArtImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius  = 16
        return imageView
    }()
    
    private let deleteButton = CustomButtons(image: .delete)
                                             
        
    
    //MARK: - Properties
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        targetButtons()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        self.addSubview(myArtImageView)
        self.addSubview(deleteButton)
        setuoCons()
    }
    
    func targetButtons() {
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func deleteButtonTapped() {
        myArtCellinterface?.clickedButton(indexPath ?? [])
    }
    
}
        
    
    //MARK: - Configure Constrain
    extension MyArtCell {
        
        func setuoCons() {
            NSLayoutConstraint.activate([
                
                myArtImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                myArtImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
                myArtImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
                myArtImageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
                
                deleteButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 10),
                deleteButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
                deleteButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,constant: -145),
                deleteButton.heightAnchor.constraint(equalToConstant: 30)
                
                
                
               
            ])
        }
        
    }

