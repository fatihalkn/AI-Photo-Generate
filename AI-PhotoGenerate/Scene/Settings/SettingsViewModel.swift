//
//  SettingsViewModel.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 26.03.2024.
//

import Foundation

class SettingsViewModel {
    
    var settingsData: [SettingsItem] = [SettingsItem(type: .shareUs, title: "Share"),
                                        SettingsItem(type: .followUs, title: "Follow Us"),
                                        SettingsItem(type: .rateUs, title: "About X"),
                                        SettingsItem(type: .restorePurchase, title: "Restore Purchase"),
                                        SettingsItem(type: .support("af.alkanfatih@gmail.com"), title: "Support"),
                                        SettingsItem(type: .terms, title: "Terms"),
                                        SettingsItem(type: .privacyPolicy, title: "Privacy Policy")]

}
