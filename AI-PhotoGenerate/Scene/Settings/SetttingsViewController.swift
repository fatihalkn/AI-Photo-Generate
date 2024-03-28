//
//  SetttingsViewController.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 26.03.2024.
//

import Foundation
import UIKit

class SetttingsViewController: UIViewController {
    
    let settingsViewModel = SettingsViewModel()
    
    private let settingsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .main
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        title = "Settings"
        setupUI()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setupUI() {
        view.backgroundColor = .main
        view.addSubview(settingsTableView)
        setupDelegate()
        setupRegister()
        setupCons()
        
    }
    
    func setupDelegate() {
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
    }
    
    func setupRegister() {
        settingsTableView.register(SettingsElementsCell.self, forCellReuseIdentifier: SettingsElementsCell.identifier)
    }
    
    
    
}

//MARK: - Configure TableView
extension SetttingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 230
    }
    
    private func tableView(_ tableView: UITableView, widthForHeaderInSection section: Int) -> CGFloat {
        
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.settingsData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let itemType = settingsViewModel.settingsData[indexPath.row].type
        switch itemType {
        case .shareUs:
            let text = "Uygulamayı denemelisiniz!"
            guard let image = UIImage(named: "appIcon") else { return }
            guard let url = URL(string: "https://github.com/fatihalkn") else { return }
            let activityViewController = UIActivityViewController(activityItems: [text, image, url], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        case .followUs:
            let websiteURL = URL(string: "https://github.com/fatihalkn")
            if let url = websiteURL, UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:],completionHandler: nil)
            } else {
                print("Geçersiz URL veya Açılmayan URL")
            }
        case .rateUs:
            let websiteURL = URL(string: "https://github.com/fatihalkn")
            if let url = websiteURL, UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:],completionHandler: nil)
            } else {
                print("Geçersiz URL veya Açılmayan URL")
            }
        case .restorePurchase:
            let websiteURL = URL(string: "https://github.com/fatihalkn")
            if let url = websiteURL, UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:],completionHandler: nil)
            } else {
                print("Geçersiz URL veya Açılmayan URL")
            }
        case .support(_):
            let websiteURL = URL(string: "https://github.com/fatihalkn")
            if let url = websiteURL, UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:],completionHandler: nil)
            } else {
                print("Geçersiz URL veya Açılmayan URL")
            }
        case .terms:
            let websiteURL = URL(string: "https://www.termsfeed.com/public/uploads/2021/12/sample-mobile-app-terms-conditions-template.pdf")
            if let url = websiteURL, UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:],completionHandler: nil)
            } else {
                print("Geçersiz URL veya Açılmayan URL")
            }
        case .privacyPolicy:
            let websiteURL = URL(string: "https://www.termsfeed.com/public/uploads/2021/12/sample-mobile-app-privacy-policy-template.pdf")
            if let url = websiteURL, UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:],completionHandler: nil)
            } else {
                print("Geçersiz URL veya Açılmayan URL")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: SettingsElementsCell.identifier, for: indexPath) as! SettingsElementsCell
        let settingsItem = settingsViewModel.settingsData[indexPath.row]
        cell.textLabel?.text = settingsItem.title
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .main
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = TableViewHeader()
        return headerView
    }
}
//MARK: - Configure Constrain
extension SetttingsViewController {
    
    func setupCons() {
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
