//
//  DetailController.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 22.03.2024.
//

import Foundation
import UIKit





class DetailController: UIViewController {
    
    let promptImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius  = 16
        return imageView
    }()
    
    let prompTitetLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkGray
        label.text = "Prompt: "
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let prompDescLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let detailView: UIView = {
        let detailView = UIView()
        detailView.backgroundColor = .darkText
//        detailView.layer.cornerRadius = 16
//        detailView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        detailView.translatesAutoresizingMaskIntoConstraints = false
        return detailView
    }()
    
    let tryButton = CustomButtons(title: "Try this 🤩",backroundColor: .button)
    
    let copyButton = CustomButtons(image: .cop)
    
    let shareButton = CustomButtons(image: .shared)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        buttonsTarget()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupRadius()
    }
    
    func setupUI() {
        view.addSubview(promptImageView)
        view.addSubview(detailView)
        view.addSubview(prompDescLabel)
        view.addSubview(prompTitetLabel)
        view.addSubview(tryButton)
        view.addSubview(copyButton)
        view.addSubview(shareButton)
        view.backgroundColor = .main
        setuoCons()
    }
    
    func setupRadius() {
        tryButton.layer.cornerRadius = tryButton.frame.height / 2
        tryButton.clipsToBounds = true
        
    }
    
    func buttonsTarget() {
        tryButton.addTarget(self, action: #selector(tryButtonClicked), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonClicked), for: .touchUpInside)
        copyButton.addTarget(self, action: #selector(copyButtonClicked), for: .touchUpInside)
    }
    
    @objc func tryButtonClicked() {
        if let tabBarController = tabBarController as? TabBarController,
           let homeNavController = tabBarController.viewControllers?.first as? UINavigationController,
           let homeVC = homeNavController.viewControllers.first as? HomePageController {
            UIView.transition(with: homeVC.textView, duration: 0.2, options: .beginFromCurrentState, animations: {
                   homeVC.textView.text = self.prompDescLabel.text
               }, completion: nil)
               tabBarController.selectedIndex = 0
        }
    }
    
    @objc func shareButtonClicked() {
        guard let imageToShare = promptImageView.image else { return }
        guard let promtToShare = prompDescLabel.text else { return }
        
        let activtyViewController = UIActivityViewController(activityItems: [imageToShare,promtToShare], applicationActivities: nil)
        present(activtyViewController, animated: true, completion: nil)
    }
    
    @objc func copyButtonClicked() {
        UIPasteboard.general.string = prompDescLabel.text
        
        copyButton.setImage(.copmleatecop, for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.copyButton.setImage(.cop, for: .normal)
        }
    }
}

//MARK: - Configure Constrain
extension DetailController {
    
    func setuoCons() {
        NSLayoutConstraint.activate([
            promptImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            promptImageView.leadingAnchor.constraint(equalTo: detailView.leadingAnchor),
            promptImageView.trailingAnchor.constraint(equalTo: detailView.trailingAnchor),
            promptImageView.bottomAnchor.constraint(equalTo: detailView.topAnchor,constant: 20),
            
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            
            
            prompTitetLabel.topAnchor.constraint(equalTo: detailView.topAnchor,constant: 20),
            prompTitetLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 10),
            
            prompDescLabel.topAnchor.constraint(equalTo: prompTitetLabel.bottomAnchor, constant: 10),
            prompDescLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 10),
            prompDescLabel.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -10),
            
            
            tryButton.topAnchor.constraint(equalTo: prompDescLabel.bottomAnchor, constant: 100),
            tryButton.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 30),
            tryButton.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -30),
            tryButton.heightAnchor.constraint(equalToConstant: 40),
            
            
            copyButton.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 10),
            copyButton.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -10),
            copyButton.heightAnchor.constraint(equalToConstant: 30),
            copyButton.widthAnchor.constraint(equalToConstant: 30),
            
            
            shareButton.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 10),
            shareButton.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -10),
            shareButton.heightAnchor.constraint(equalToConstant: 30),
            shareButton.widthAnchor.constraint(equalToConstant: 30)
            
            
            
            
        ])
    }
}
