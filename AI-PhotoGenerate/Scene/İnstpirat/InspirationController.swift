//
//  İnspirationController.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 22.03.2024.
//

import Foundation
import UIKit

class InspirationController: UIViewController {
    
    let ınspirationViewModel = InspirationViewModel()
    
    private let inspirationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .main
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationBarConfigure()
    }
    
    func navigationBarConfigure() {
        self.configureItems(leftTitle: "AI Inspiration", rightTitle: "PRO", rightButtonİmageFirst: UIImage(systemName: "gear")!, rightBarButtonİmageSecont: UIImage(named: "star")!)
    }
    
    func setupUI() {
        view.addSubview(inspirationCollectionView)
        setupDelegate()
        setupRegister()
        setupCons()
    }
    
    func setupDelegate() {
        inspirationCollectionView.dataSource = self
        inspirationCollectionView.delegate = self
    }
    
    func setupRegister() {
        inspirationCollectionView.register(InspirationCell.self, forCellWithReuseIdentifier: InspirationCell.identifier)
        
        inspirationCollectionView.register(InspirationReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: InspirationReusableView.identifier)
        
    }
}

//MARK: - Configure CollectionView
extension InspirationController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ınspirationViewModel.fatureArtData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = inspirationCollectionView.dequeueReusableCell(withReuseIdentifier: InspirationCell.identifier, for: indexPath) as! InspirationCell
        let data = ınspirationViewModel.fatureArtData[indexPath.item]
        cell.interface = self
        cell.inspirationImageView.image = data.image
        cell.indexPath = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWith = collectionView.frame.width / 2 - 15
        let cellHeight = collectionView.frame.height / 2 - 100
        return .init(width: cellWith, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("!")
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: InspirationReusableView.identifier, for: indexPath) as! InspirationReusableView
            header.interface = self
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width,
                      height: view.frame.size.height / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
}

//MARK: - InspirationCellDelegate, InspirationReusableViewDelegate
extension InspirationController: InspirationCellDelegate, InspirationReusableViewDelegate {
   
    
    func tappedCell(_ indexPath: IndexPath) {
        let vc = DetailController()
        vc.prompDescLabel.text = ınspirationViewModel.popularData[indexPath.item].prompt
        vc.promptImageView.image = ınspirationViewModel.popularData[indexPath.item].image
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func clickedTryButton(indexPath: IndexPath?) {
        guard let indexPath else { return }
        let vc = DetailController()
        vc.prompDescLabel.text = ınspirationViewModel.fatureArtData[indexPath.item].prompt
        vc.promptImageView.image = ınspirationViewModel.fatureArtData[indexPath.item].image
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
}

extension InspirationController {
    
    func setupCons() {
        NSLayoutConstraint.activate([
            inspirationCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            inspirationCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            inspirationCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            inspirationCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
