//
//  MyArt.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 22.03.2024.
//

import Foundation
import UIKit

class MyArt: UIViewController {
    
    let viewModel = MyArdViewModel()
    
    let myArtCollectionView: UICollectionView = {
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
        viewModel.successCallback = {
            self.myArtCollectionView.reloadData()
        }
        viewModel.getData()
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setupUI() {
        view.addSubview(myArtCollectionView)
        setupDelegate()
        setupRegister()
        setuoCons()
        navigationBarConfigure()
    }
    
    func setupDelegate() {
        myArtCollectionView.delegate = self
        myArtCollectionView.dataSource = self
        
    }
    
    func setupRegister() {
        myArtCollectionView.register(MyArtCell.self, forCellWithReuseIdentifier: MyArtCell.identifier)
        
    }
    
    func navigationBarConfigure() {
        self.configureItems(leftTitle: "My Art 🌃", rightTitle: "PRO", rightButtonİmageFirst: UIImage(systemName: "gear")!, rightBarButtonİmageSecont: UIImage(named: "star")!)
    }
    
    
}

//MARK: - Configure CollectionViewü
extension MyArt: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.myArts.count
                
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myArtCollectionView.dequeueReusableCell(withReuseIdentifier: MyArtCell.identifier, for: indexPath) as! MyArtCell
        let data = viewModel.myArts[indexPath.item].imageData
            cell.indexPath = indexPath
            cell.myArtCellinterface = self
        cell.myArtImageView.image = UIImage(data: data!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWith : CGFloat = collectionView.frame.width / 2 - 20
        let cellHeight: CGFloat = collectionView.frame.height / 4
        return .init(width: cellWith, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageData = viewModel.myArts[indexPath.item].imageData
        let prompt = viewModel.myArts[indexPath.item].imagePrompt
        let detailVC = DetailController()
        detailVC.promptImageView.image = UIImage(data: imageData!)
        detailVC.prompDescLabel.text = prompt
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}

//MARK: -  MyArtCellDelegate Protocol
extension MyArt: MyArtCellDelegate {
    func clickedButton(_ indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Warning", message: "Are you sure you want to delete this İmage?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(cancelAction)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                let idToDelete = self.viewModel.myArts[indexPath.item].id
            CoreDataModel.shared.deleteItem(withID: idToDelete!)
                self.viewModel.myArts.remove(at: indexPath.item)
            self.myArtCollectionView.reloadData()
                
            }
        
            alertController.addAction(deleteAction)
            
            present(alertController, animated: true)
    }

}

//MARK: - Configure Constrains
extension MyArt {
    func setuoCons() {
        
        NSLayoutConstraint.activate([
            myArtCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myArtCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            myArtCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            myArtCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
}
