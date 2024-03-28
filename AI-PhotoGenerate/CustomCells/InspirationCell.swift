//
//  InspirationCell.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 22.03.2024.
//

import UIKit
protocol InspirationCellDelegate {
    func clickedTryButton(indexPath: IndexPath?)
}

class InspirationCell: UICollectionViewCell {

    static let identifier = "InspirationCell"
    var interface: InspirationCellDelegate?
    let inspirationImageView: UIImageView = {
       let imageView = UIImageView()
       imageView.contentMode = .scaleAspectFill
       imageView.clipsToBounds = true
       imageView.backgroundColor = .white
       imageView.translatesAutoresizingMaskIntoConstraints = false
       imageView.layer.cornerRadius  = 16
       return imageView
   }()
   

    private let tryButton: CustomButtons = {
        let gradientColors: [CGColor] = [UIColor.label.cgColor, UIColor.purple.cgColor]
        return CustomButtons(title: "Try",
                             titleColor: .rgb,
                             font: .systemFont(ofSize: 13, weight: .bold),
                             gradientColors: gradientColors)
    }()
    
    
    //MARK: - Properties
    var indexPath: IndexPath?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        buttonsTarget()
    }
 
    override func layoutSubviews() {
        super.layoutSubviews()
        setupRadius()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupRadius() {
        tryButton.layer.cornerRadius = tryButton.frame.height / 2
        tryButton.clipsToBounds = true
    }
    
    func setupUI() {
        self.addSubview(inspirationImageView)
        self.addSubview(tryButton)
        setuoCons()
    }
    
    func buttonsTarget() {
        tryButton.addTarget(self, action: #selector(tappedTryButton), for: .touchUpInside)
    }
    
    @objc func tappedTryButton() {
        interface?.clickedTryButton(indexPath: indexPath)

    }
    
}
//MARK: - Configure Constrain
extension InspirationCell {
    
    func setuoCons() {
        NSLayoutConstraint.activate([
            
            inspirationImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            inspirationImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            inspirationImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            inspirationImageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            tryButton.topAnchor.constraint(equalTo: inspirationImageView.topAnchor,constant: 200),
            tryButton.leadingAnchor.constraint(lessThanOrEqualTo: inspirationImageView.leadingAnchor,constant:110),
            tryButton.trailingAnchor.constraint(equalTo: inspirationImageView.trailingAnchor,constant: -10),
            tryButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}
