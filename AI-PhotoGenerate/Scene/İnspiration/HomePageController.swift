//
//  HomePageController.swift
//  TextToSticker
//
//  Created by Fatih on 16.03.2024.
//

import Foundation
import UIKit
import CoreData

class HomePageController: UIViewController {
    
    let homeViewModel = HomeViewModel()
    
     let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.textColor = .white
        textView.textAlignment = .left
        textView.textContainerInset = UIEdgeInsets(top: 40, left: 10, bottom: 10, right: 10)
        textView.backgroundColor = .textview
        return textView
    }()
    
    
    
    private let promptTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Enter A Prompt"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .title
        return label
    }()
    
    private let selectStyleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Select Style"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let optionalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = "optional"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()
    
    private let styleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let textToPhotoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "Text to image"
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .texToPhoto
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb
        return label
    }()
    
    
    
    private let supriseMeButton = CustomButtons(title: "Suprise me",
                                                titleColor: .rgb,
                                                font: .systemFont(ofSize: 12, weight: .bold),
                                                backroundColor: .texToPhoto)
    
    private let seeAllButton = CustomButtons(title: "See all >",
                                             titleColor: .rgb,
                                             font: .systemFont(ofSize: 15, weight: .bold),
                                             backroundColor: nil)
    private let createButton = CustomButtons(title: "Create >",
                                             titleColor: .rgb,
                                             font: .systemFont(ofSize: 20, weight: .bold),
                                             backroundColor: .button)
    private let clearButton = CustomButtons(title: "Clear Text",
                                            titleColor: .rgb,
                                            font: .systemFont(ofSize: 10, weight: .thin),
                                            backroundColor: .texToPhoto)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationBarConfigure()
        setupCons()
        setupRegister()
        setupDelegate()
        buttonsTarget()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupRadius()
    }
    
    func setupUI() {
        view.addSubview(textView)
        view.addSubview(textToPhotoLabel)
        view.addSubview(promptTitleLabel)
        view.addSubview(supriseMeButton)
        view.addSubview(selectStyleLabel)
        view.addSubview(optionalLabel)
        view.addSubview(seeAllButton)
        view.addSubview(styleCollectionView)
        view.addSubview(createButton)
        view.addSubview(clearButton)
        view.backgroundColor = UIColor(named: "mainColor")
    }
    
    func setupRegister() {
        styleCollectionView.register(SelectStyleCell.self, forCellWithReuseIdentifier:SelectStyleCell.identifier)
        
    }
    
    func setupDelegate() {
        styleCollectionView.delegate = self
        styleCollectionView.dataSource = self

    }
    
    func buttonsTarget() {
        createButton.addTarget(self, action: #selector(clickedCreateButton), for: .touchUpInside)
        seeAllButton.addTarget(self, action: #selector(clickedSeeAllButton), for: .touchUpInside)
        supriseMeButton.addTarget(self, action: #selector(clickedSupriseMeButton), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)

    }
    
    @objc func clickedSupriseMeButton() {
        if let randomElement = homeViewModel.supriseMe.randomElement() {
            textView.text = randomElement.textPrompt
        } else {
            textView.text = "A near fatal hot chocolate accident."
        }
    }
    
    @objc func clickedCreateButton() {
        if !homeViewModel.isTextViewEmpty(textView.text) { 
            self.textView.shake()
            self.promptTitleLabel.shake()
            self.supriseMeButton.shake()
            return }
        homeViewModel.textViewTextDidChange(textView.text)
        showLoading(text: "", type: .circleStrokeSpin, interaction: false)
        homeViewModel.createButtonTapped { generateModel in
            let vc = GenarateController()
            vc.photoPromptTitleLabel.text = self.textView.text
            vc.configure(data: generateModel)
            self.navigationController?.pushViewController(vc, animated: true)
            self.removeLoading()
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let saveData = NSEntityDescription.insertNewObject(forEntityName: "Art", into: context)
            let imagePress = vc.genareteImage.image?.jpegData(compressionQuality: 0.5)
            saveData.setValue(imagePress, forKey: "image")
            saveData.setValue(UUID(), forKey: "id")
            saveData.setValue(self.textView.text, forKey: "prompt")
            
            do {
                try context.save()
                print("Saved Succes")
            } catch {
                print("Fail Saved")
            }
            
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "newData"), object: nil)
            
        }
    }
    
    @objc func clickedSeeAllButton() {
        let selectedStyle = homeViewModel.styles[homeViewModel.lastIndexACtive.item]
        let vc = SeeAllController()
        vc.selectedStyle = selectedStyle
        vc.seeAllDelegate = self
        navigationController?.pushViewController(vc, animated: true)
        print("See all butonuna bastın")
    }
    
    @objc func clearButtonTapped() {
        textView.text = ""
    }
    
    func setupRadius() {
        textToPhotoLabel.layer.cornerRadius = textToPhotoLabel.frame.height / 2
        textToPhotoLabel.clipsToBounds = true
        
        supriseMeButton.layer.cornerRadius = supriseMeButton.frame.height / 2
        supriseMeButton.clipsToBounds = true
        
        createButton.layer.cornerRadius = createButton.frame.height / 2
        createButton.clipsToBounds = true
        
        clearButton.layer.cornerRadius = clearButton.frame.height / 2
        createButton.clipsToBounds = true
        
        textView.layer.cornerRadius = 16
    }
    
    func navigationBarConfigure() {
        self.configureItems(leftTitle: "Creat", rightTitle: "PRO", rightButtonİmageFirst: UIImage(systemName: "gear")!, rightBarButtonİmageSecont: UIImage(named: "star")!)
    }
    
    func addStyle(style: StyleModel) {
        
        if let existingIndex = homeViewModel.styles.firstIndex(where: {$0.lowercaseName == style.lowercaseName}) {
            let indexPath = IndexPath(item: existingIndex, section: 0)
            styleCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            homeViewModel.lastIndexACtive = indexPath
            homeViewModel.postModel.stylePreset = style.lowercaseName
            styleCollectionView.reloadData()
        } else {
            homeViewModel.styles.append(style)
            let lastIndex = homeViewModel.styles.count - 1
            let lastIndexPath = IndexPath(item: lastIndex, section: 0)
            homeViewModel.lastIndexACtive = lastIndexPath
            homeViewModel.postModel.stylePreset = style.lowercaseName
            styleCollectionView.reloadData()
            styleCollectionView.scrollToItem(at: lastIndexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

//MARK: - CollectionView Configure
extension HomePageController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.styles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nameData = homeViewModel.styles[indexPath.item]
        let cell = styleCollectionView.dequeueReusableCell(withReuseIdentifier: SelectStyleCell.identifier, for: indexPath) as! SelectStyleCell
        
        if indexPath == homeViewModel.lastIndexACtive {
            cell.layer.borderColor = UIColor.rgb.cgColor
            cell.layer.borderWidth = 2
            cell.layer.cornerRadius = 16
        } else {
            cell.layer.borderColor = UIColor.clear.cgColor
            cell.layer.borderWidth = 0
            cell.layer.cornerRadius = 16
        }
        cell.styleLabel.text = nameData.styleName
        cell.styleImageView.image = nameData.styleImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.homeViewModel.lastIndexACtive != indexPath {
            let cell = collectionView.cellForItem(at: indexPath) as? SelectStyleCell
            cell?.layer.borderColor = UIColor.rgb.cgColor
            cell?.layer.borderWidth = 2
            cell?.layer.cornerRadius = 16
        }
        
        let previousCell = collectionView.cellForItem(at: homeViewModel.lastIndexACtive) as? SelectStyleCell
        previousCell?.layer.borderColor = UIColor.clear.cgColor
        previousCell?.layer.borderWidth = 0
        previousCell?.layer.cornerRadius = 16
        self.homeViewModel.lastIndexACtive = indexPath
        homeViewModel.didSelectStyleAt(indexPath: indexPath)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.frame.height - 30
        let cellWeight = collectionView.frame.width / 2
        return .init(width: cellWeight, height: cellHeight)
    }
}

//MARK: - SeeAllControllerDelegate Protocol
extension HomePageController: SeeAllControllerDelegate {
    func didSelectStyle(selectedStyle: StyleModel) {
        addStyle(style: selectedStyle)
        
        if let index = homeViewModel.styles.firstIndex(where: { $0.lowercaseName == selectedStyle.lowercaseName }) {
            let indexPath = IndexPath(item: index, section: 0)
            styleCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
        }
    }
}

//MARK: - Configure Constrains
extension HomePageController {
    
    func setupCons() {

        NSLayoutConstraint.activate([
            textToPhotoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textToPhotoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 110),
            textToPhotoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -110),
            textToPhotoLabel.heightAnchor.constraint(equalToConstant: 30),
            
            textView.topAnchor.constraint(equalTo: textToPhotoLabel.bottomAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            textView.heightAnchor.constraint(equalToConstant: 150),
            
            promptTitleLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 10),
            promptTitleLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 10),
            promptTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo:textView.trailingAnchor),
            promptTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            supriseMeButton.bottomAnchor.constraint(equalTo: textView.bottomAnchor,constant: -10),
            supriseMeButton.leadingAnchor.constraint(equalTo: clearButton.leadingAnchor,constant: 200),
            supriseMeButton.trailingAnchor.constraint(equalTo: textView.trailingAnchor,constant: -10),
            supriseMeButton.heightAnchor.constraint(equalToConstant: 30),
            
            selectStyleLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20),
            selectStyleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            selectStyleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            optionalLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20),
            optionalLabel.leadingAnchor.constraint(equalTo: selectStyleLabel.trailingAnchor, constant: 10),
            optionalLabel.heightAnchor.constraint(equalToConstant: 30),
            
            seeAllButton.topAnchor.constraint(equalTo: textView.bottomAnchor,constant: 20),
            seeAllButton.leadingAnchor.constraint(lessThanOrEqualTo: optionalLabel.trailingAnchor,constant: 100),
            seeAllButton.trailingAnchor.constraint(equalTo: textView.trailingAnchor,constant: -20),
            seeAllButton.heightAnchor.constraint(equalToConstant: 30),
            
            styleCollectionView.topAnchor.constraint(equalTo: selectStyleLabel.bottomAnchor, constant: 10),
            styleCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 30),
            styleCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            styleCollectionView.heightAnchor.constraint(equalToConstant: 150),
            
            createButton.topAnchor.constraint(equalTo: styleCollectionView.bottomAnchor,constant: 150),
            createButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 30),
            createButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            createButton.heightAnchor.constraint(equalToConstant: 60),
            
            clearButton.bottomAnchor.constraint(equalTo: textView.bottomAnchor,constant: -10),
            clearButton.leadingAnchor.constraint(equalTo: textView.leadingAnchor,constant: 10),
            clearButton.heightAnchor.constraint(equalToConstant: 12),
            clearButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}
