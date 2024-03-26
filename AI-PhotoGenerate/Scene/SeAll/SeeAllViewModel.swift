//
//  SeeAllViewModel.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 21.03.2024.
//

import Foundation


class SeeAllViewModel {
    
    var lastIndexACtive: IndexPath = IndexPath(row: 0, section: 0)
    
    var postModel = PostModel(height: 1024,
                              width: 1024,
                              samples: 1,
                              steps: 40,
                              cfgScale: 5,
                              seed: 0,
                              stylePreset: nil,
                              textPrompts: [])
    
    var styles: [StyleModel] = [.init(styleName: "Enhance", styleImage: .enhance, lowercaseName: "enhance"),
                                .init(styleName: "Anime", styleImage: .anime, lowercaseName: "anime"),
                                .init(styleName: "Photographic", styleImage: .photographic, lowercaseName: "photographic"),
                                .init(styleName: "Digital Art", styleImage: .digitalart, lowercaseName: "digital-art"),
                                .init(styleName: "Comic Book", styleImage: .comicbook, lowercaseName: "comic-book"),
                                .init(styleName: "Fantasy Art", styleImage: .fantasyart, lowercaseName: "fantasy-art"),
                                .init(styleName: "Line Art", styleImage: .lineart, lowercaseName: "line-art"),
                                .init(styleName: "Analog Film", styleImage: .analog, lowercaseName: "analog-film"),
                                .init(styleName: "Neon Punk", styleImage: .neon, lowercaseName: "neon-punk"),
                                .init(styleName: "Isometric", styleImage: .isometric, lowercaseName: "isometric"),
                                .init(styleName: "Low Poly", styleImage: .low, lowercaseName: "low-poly"),
                                .init(styleName: "Origima", styleImage:.origima , lowercaseName: "origami"),
                                .init(styleName: "Modeling Compound", styleImage: .compopund, lowercaseName: "modeling-compound"),
                                .init(styleName: "Cinematic", styleImage: .cinematic, lowercaseName: "cinematic"),
                                .init(styleName: "Pixel Art", styleImage: .pixel, lowercaseName: "pixel-art"),
                                .init(styleName: "Tile Texture", styleImage: .texture, lowercaseName: "tile-texture")]
    
    func didSelectStyleAt(indexPath: IndexPath) {
        let selectedStyle = styles[indexPath.item].lowercaseName
        postModel.stylePreset = selectedStyle
    }
}
