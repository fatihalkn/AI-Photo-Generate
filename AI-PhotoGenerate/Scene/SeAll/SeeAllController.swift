//
//  SeeAllController.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 21.03.2024.
//

import Foundation
import UIKit

protocol SeeAllControllerDelegate: AnyObject {
    func didSelectStyle(selectedStyle: StyleModel)
}

class SeeAllController: UIViewController {
    
    let seeAllViewModel = SeeAllViewModel()
    
    var seeAllDelegate: SeeAllControllerDelegate?
    
    var selectedStyle: StyleModel?
    
    private let seeAllCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 70, right: 10)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let contiuneButton = CustomButtons(title: "Contiune",titleColor: .white,font: .systemFont(ofSize: 15, weight: .bold),backroundColor: .button)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupRadius()
    }
    
    func setupUI() {
        view.addSubview(seeAllCollectionView)
        view.addSubview(contiuneButton)
        view.backgroundColor = .main
        navigationItem.title = "Selected Style"
        setLastIndexActive()
        setupRegister()
        setupDelegate()
        setupCons()
        addTarget()
    }
    
    func setLastIndexActive() {
        guard let selectedStyle else { return }
        if let index = seeAllViewModel.styles.firstIndex(where: { $0.lowercaseName == selectedStyle.lowercaseName }) {
            let indexPath = IndexPath(item: index, section: 0)
            seeAllViewModel.lastIndexACtive = indexPath
        }
    }
    
    func setupRegister() {
        seeAllCollectionView.register(SelectStyleCell.self, forCellWithReuseIdentifier: SelectStyleCell.identifier)
    }
    
    func setupDelegate() {
        seeAllCollectionView.delegate = self
        seeAllCollectionView.dataSource = self
    }
    
    func setupRadius() {
        contiuneButton.layer.cornerRadius = contiuneButton.frame.height / 2
        contiuneButton.clipsToBounds = true
    }
    
    func addTarget() {
        contiuneButton.addTarget(self, action: #selector(clickedContiuneButton), for: .touchUpInside)
    }
    
    @objc func clickedContiuneButton() {
        if let selectedIndexPath = seeAllCollectionView.indexPathsForSelectedItems?.first {
            seeAllDelegate?.didSelectStyle(selectedStyle: seeAllViewModel.styles[selectedIndexPath.item])
        }
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Configure CollectionView
extension SeeAllController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return seeAllViewModel.styles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nameData = seeAllViewModel.styles[indexPath.item]
        let cell = seeAllCollectionView.dequeueReusableCell(withReuseIdentifier: SelectStyleCell.identifier, for: indexPath) as! SelectStyleCell
        if indexPath == seeAllViewModel.lastIndexACtive {
            cell.layer.borderColor = UIColor.rgb.cgColor
            cell.layer.borderWidth = 2
            cell.layer.cornerRadius = 16
        } else {
            cell.layer.borderColor = UIColor.clear.cgColor
            cell.layer.borderWidth = 0
            cell.layer.cornerRadius = 16
            
        }
        cell.styleImageView.image = nameData.styleImage
        cell.styleLabel.text = nameData.styleName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWitdh: CGFloat = (collectionView.frame.width - (20 + 20)) / 3
        let cellHeight: CGFloat = collectionView.frame.height / 4
        return .init(width: cellWitdh, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.seeAllViewModel.lastIndexACtive != indexPath {
            let cell = collectionView.cellForItem(at: indexPath) as? SelectStyleCell
            let selectedStyle = seeAllViewModel.styles[indexPath.item]
            seeAllDelegate?.didSelectStyle(selectedStyle: selectedStyle)
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            cell?.layer.borderColor = UIColor.rgb.cgColor
            cell?.layer.borderWidth = 2
            cell?.layer.cornerRadius = 16
        }
        let previousSelectedIndexPath = seeAllViewModel.lastIndexACtive
        let previousCell = collectionView.cellForItem(at: previousSelectedIndexPath) as? SelectStyleCell
        previousCell?.layer.borderColor = UIColor.clear.cgColor
        previousCell?.layer.borderWidth = 0
        previousCell?.layer.cornerRadius = 16
        self.seeAllViewModel.lastIndexACtive = indexPath
    }
    
}

//MARK: - Configure Constrain
extension SeeAllController {
    func setupCons() {
        NSLayoutConstraint.activate([
            seeAllCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            seeAllCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            seeAllCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            seeAllCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contiuneButton.topAnchor.constraint(equalTo: seeAllCollectionView.bottomAnchor,constant: -80),
            contiuneButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 30),
            contiuneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -30),
            contiuneButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
