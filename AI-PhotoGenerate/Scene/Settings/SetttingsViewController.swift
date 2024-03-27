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
        let tableView = UITableView()
        tableView.backgroundColor = .main
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
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
        setupHeader()
        
    }
    
    func setupDelegate() {
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
    }
    
    func setupRegister() {
        settingsTableView.register(SettingsElementsCell.self, forCellReuseIdentifier: SettingsElementsCell.identifier)
    }
    
    func setupHeader() {
        let headerView = TableViewHeader(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 250))
        settingsTableView.tableHeaderView = headerView
    }
    
}

//MARK: - Configure TableView
extension SetttingsViewController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.settingsData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: SettingsElementsCell.identifier, for: indexPath) as! SettingsElementsCell
        cell.textLabel?.text = settingsViewModel.settingsData[indexPath.row].settingsItems
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .main
        return cell
        
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
