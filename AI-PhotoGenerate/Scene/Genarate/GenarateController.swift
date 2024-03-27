//
//  GenarateController.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 19.03.2024.
//

import Foundation
import UIKit



class GenarateController: UIViewController {
    var padding: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    var photoPromptTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 3
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var bacroundView: UIView = {
        let bacroundView = UIView()
        bacroundView.backgroundColor = .texToPhoto
        bacroundView.translatesAutoresizingMaskIntoConstraints = false
        return bacroundView
    }()
    
    var removeWatermarLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.text = "Remove Watermark"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    let proButton = CustomButtons(title: "PRO",
                                  titleColor: .white,
                                  font: .systemFont(ofSize: 15, weight: .bold),
                                  backroundColor: .texToPhoto, image: .star)
    
    let saveButton = CustomButtons(title: "Save",
                                   titleColor: .white,
                                   font: .systemFont(ofSize: 20, weight: .bold),
                                   backroundColor: .button,
                                   image: .dowloand)
    
    let shareButton = CustomButtons(title: "Share",
                                   titleColor: .white,
                                   font: .systemFont(ofSize: 20, weight: .bold),
                                    backroundColor: .button,
                                    image: .shared)
    
    let genareteImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCons()
        buttonTargets()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupRadius()
    }
    
    func setupUI() {
        view.addSubview(shareButton)
        view.addSubview(bacroundView)
        view.addSubview(removeWatermarLabel)
        view.addSubview(photoPromptTitleLabel)
        view.addSubview(proButton)
        view.addSubview(saveButton)
        view.addSubview(genareteImage)
    }
    
    func setupRadius() {
        saveButton.layer.cornerRadius = 16
        saveButton.clipsToBounds = true
        
        shareButton.layer.cornerRadius = 16
        shareButton.clipsToBounds = true
        
        bacroundView.layer.cornerRadius = 16
        bacroundView.clipsToBounds = true
        
        
        proButton.layer.cornerRadius = 16
        proButton.clipsToBounds = true
        
        
    }
    
    func buttonTargets() {
        saveButton.addTarget(self, action: #selector(clickedSaveButton), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(clickedShareButton), for: .touchUpInside)
    }
    
    @objc func clickedShareButton() {
        guard let imageToShare = genareteImage.image else { return }
        
        let activtyViewController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
        present(activtyViewController, animated: true, completion: nil)
    }
    
    @objc func clickedSaveButton() {
        guard let imageToSave = genareteImage.image else { return }
        
        UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)

    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            if let error = error {
                print("Error saving image: \(error.localizedDescription)")
            } else {
                showSucceed(text: "Picture saved to photo", interaction: false, delay: 2)
                print("Image saved successfully")
            }
        }
    
    func configure(data: GenerateModel) {
        guard let base64String = data.response.artifacts?.first?.base64 else {
            return
            
        }
        
        if let imageData = Data(base64Encoded: base64String),
            let image = UIImage(data: imageData) {
            print(imageData)
            self.genareteImage.image = image
        } else {
            print("error")
        }
        
        
    }
    
}

//MARK: -  Configure Constrains
extension GenarateController {
    func setupCons() {
        NSLayoutConstraint.activate([
            photoPromptTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoPromptTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            photoPromptTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10),
            photoPromptTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
                                                         
            
            
            genareteImage.topAnchor.constraint(equalTo:photoPromptTitleLabel.bottomAnchor,constant: 20),
            genareteImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            genareteImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10),
            genareteImage.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            
            
            
            proButton.topAnchor.constraint(equalTo: genareteImage.bottomAnchor,constant: 10),
            proButton.leadingAnchor.constraint(greaterThanOrEqualTo:view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            proButton.trailingAnchor.constraint(equalTo: bacroundView.trailingAnchor,constant: -10),
            proButton.heightAnchor.constraint(equalToConstant: 50),
            
            removeWatermarLabel.topAnchor.constraint(equalTo: genareteImage.bottomAnchor,constant: 10),
            removeWatermarLabel.leadingAnchor.constraint(equalTo: bacroundView.leadingAnchor, constant: 10),
            removeWatermarLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            removeWatermarLabel.heightAnchor.constraint(equalToConstant: 50),
            
            bacroundView.topAnchor.constraint(equalTo: genareteImage.bottomAnchor, constant: 10),
            bacroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            bacroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            bacroundView.heightAnchor.constraint(equalToConstant: 50),
            
            
            saveButton.topAnchor.constraint(equalTo: proButton.bottomAnchor,constant: 10),
            saveButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            saveButton.widthAnchor.constraint(equalTo: bacroundView.widthAnchor, multiplier: 0.5),
            
            
            shareButton.topAnchor.constraint(equalTo: proButton.bottomAnchor,constant: 10),
            shareButton.leadingAnchor.constraint(equalTo: saveButton.trailingAnchor, constant: 10),
            shareButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10),
            shareButton.heightAnchor.constraint(equalToConstant: 40)
            
            
        ])
    }
}
