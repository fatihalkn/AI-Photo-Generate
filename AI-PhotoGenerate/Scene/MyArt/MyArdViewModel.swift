//
//  MyArdViewModel.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 25.03.2024.
//

import Foundation

class MyArdViewModel {
    
    var myArts: [MyArtCollectionViewItem] = []
    var successCallback: (() -> Void)?
    
    func getData() {
        myArts = CoreDataModel.shared.getData()
        successCallback?()
    }
   
}
