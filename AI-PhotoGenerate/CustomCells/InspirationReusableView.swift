//
//  InspirationReusableView.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 22.03.2024.
//

import UIKit
protocol InspirationReusableViewDelegate {
    func tappedCell()
}
class InspirationReusableView: UICollectionReusableView {
    static let identifier = "InspirationReusableView"
    
    var interface:InspirationReusableViewDelegate?
    
    let ınspirationViewModel = InspirationViewModel()

    private let headerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let popularPromptsLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular AI Propmts ✨"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let featuredArtLabel: UILabel = {
        let label = UILabel()
        label.text = "Featured Art"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(featuredArtLabel)
        self.addSubview(popularPromptsLabel)
        self.addSubview(headerCollectionView)
        setupRegister()
        setupDelegate()
        setupCons()
    }
    
    func setupRegister() {
        headerCollectionView.register(InspirationCell.self, forCellWithReuseIdentifier: InspirationCell.identifier)
    }
    
    func setupDelegate() {
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
    }
    
}

//MARK: -  Configure CollectionView

extension InspirationReusableView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ınspirationViewModel.popularData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = headerCollectionView.dequeueReusableCell(withReuseIdentifier: InspirationCell.identifier, for: indexPath) as! InspirationCell
        let data = ınspirationViewModel.popularData[indexPath.item]
        cell.inspirationImageView.image = data.image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = (collectionView.frame.width - 50) / 2
        let cellHight: CGFloat = collectionView.frame.height - 50
        return(.init(width: cellWidth, height: cellHight))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interface?.tappedCell()
    }
}

//MARK: - Configure Constrain
extension InspirationReusableView {
    func setupCons() {
        NSLayoutConstraint.activate([
            headerCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            headerCollectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            headerCollectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            headerCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            popularPromptsLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: -15),
            popularPromptsLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            popularPromptsLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,constant: -50),
            popularPromptsLabel.heightAnchor.constraint(equalToConstant: 40),
            
            featuredArtLabel.topAnchor.constraint(equalTo: headerCollectionView.topAnchor,constant: 190),
            featuredArtLabel.leadingAnchor.constraint(equalTo: headerCollectionView.leadingAnchor),
            featuredArtLabel.trailingAnchor.constraint(equalTo: headerCollectionView.trailingAnchor,constant: -50),
            featuredArtLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
