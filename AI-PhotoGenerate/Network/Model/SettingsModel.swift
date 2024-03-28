//
//  SettingsModel.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 28.03.2024.
//

import Foundation

struct SettingsItem {
    let type: SettingsItemType
    let title: String
}

enum SettingsItemType {
    case shareUs
    case followUs
    case rateUs
    case restorePurchase
    case support(String)
    case terms
    case privacyPolicy
}
