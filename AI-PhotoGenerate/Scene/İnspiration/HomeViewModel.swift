//
//  HomeViewModel.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 19.03.2024.
//

import Foundation


class HomeViewModel {
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
                                   .init(styleName: "Fantasy Art", styleImage: .fantasyart, lowercaseName: "fantasy-art")]
    
    var supriseMe: [SupriseModel] = [.init(textPrompt: "Someone tells your character a secret they don't want to hear."),
                                     .init(textPrompt: "A myth that turns out to be true."),
                                     .init(textPrompt: "An epic case of humiliation."),
                                     .init(textPrompt: "Someone is deathly afraid of shopping carts"),
                                     .init(textPrompt: "Your character avoids conflict at all costs."),
                                     .init(textPrompt: "A myth that turns out to be true"),
                                     .init(textPrompt: "Everyone thinks your character is lying about something"),
                                     .init(textPrompt: "A surprise at a boxing gym."),
                                     .init(textPrompt: "Your character accidentally commits a crime."),
                                     .init(textPrompt: "The coldest day of the year."),
                                     .init(textPrompt: "A group of people entertained by a rake."),
                                     .init(textPrompt: "Your character picks up a hitchhiker."),
                                     .init(textPrompt: "A frightening School Picture Day."),
                                     .init(textPrompt: "A National Yo-Yo Day celebration"),
                                     .init(textPrompt: "Spooky stories at an arcade"),
                                     .init(textPrompt: "A group of strangers get stranded at a ski slope"),
                                     .init(textPrompt: "Taco Tuesday at an arboretum."),
                                     .init(textPrompt: "An extremely absurd babysitting job."),
                                     .init(textPrompt: "The honeymoon from hell."),
                                     .init(textPrompt: "A harp, an acorn and mistletoe."),
                                     .init(textPrompt: "A group of people ruins a first date"),
                                     .init(textPrompt: "Two people get into an argument about a bagel."),
                                     .init(textPrompt: "A rainy evening at the grocery store."),
                                     .init(textPrompt: "Your character has an unwanted visitor."),
                                     .init(textPrompt: "Inappropriate funeral attire."),
                                     .init(textPrompt: "Your character has an unwanted visitor.")]
    
    func getPostModelPhoto(completion: @escaping (ResponseModel) -> Void) {
        NetworkManager.shared.sendingPostRequest(parameters: postModel) { (result: ResponseModel) in
            completion(result)
        }
    }
    
    
    
    func isTextViewEmpty(_ text: String?) -> Bool {
        guard let text, !text.isEmpty else { return false }
        return true
    }
    
    func textViewTextDidChange(_ text: String?) {
        guard let text, !text.isEmpty else { return }
        let textPrompt = TextPrompt(text: text, weight: 1)
        postModel.textPrompts?.removeAll()
        postModel.textPrompts?.append(textPrompt)
    }
    
    func didSelectStyleAt(indexPath: IndexPath) {
        let selectedStyle = styles[indexPath.item].lowercaseName
        postModel.stylePreset = selectedStyle
    }
    
    func createButtonTapped(completion: @escaping (GenerateModel) -> Void) {
        getPostModelPhoto { responseModel in
            let title = self.postModel.textPrompts?.first?.text ?? "Empty"
            let generateModel = GenerateModel(title: title, response: responseModel)
            completion(generateModel)
        }
    }


}

