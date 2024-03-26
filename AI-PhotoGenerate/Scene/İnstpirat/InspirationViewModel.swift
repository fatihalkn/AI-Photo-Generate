//
//  InspirationViewModel.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 22.03.2024.
//

import Foundation

class InspirationViewModel {
    
    var fatureArtData: [InspirationModel] = [.init(prompt: "Cute aesthetic, a tiny cute translucent polycarbonate robot with an LED screen face, emoticon, stunning unreal engine render, intricate details", image: ._1),
                                               .init(prompt: "Desire and admiration alana with a mischievous smile", image: ._2),
                                               .init(prompt: "A cute monkey using a calculator, doing math, stunning unreal engine render, 8k", image: ._3),
                                               .init(prompt: "Portrait of zelda in a black and gold dress", image: ._4),
                                               .init(prompt: "Cyberpunk digital painting of princess mononoke", image: ._5),
                                               .init(prompt: "Handsome male, trending pixiv fanbox, the style of 90's vintage anime", image: ._6),
                                               .init(prompt: "Bugs bunny is wearing beige sports pants, a black hoodie", image: ._7),
                                               .init(prompt: "Cute lofi girl in front of his computer in her cozy and messy room", image: ._8),]   
    
    
    var popularData: [PopularAIModel] = [.init(prompt: "Body portrait photography, in a black laboratory full of cables", image: .p1),
                                         .init(prompt: "An eveil man wearing a coat in the rain with a half-robot face", image: .p2),
                                         .init(prompt: "All glassblowing superrealism urban style one vampıre reaper on a horse still", image: .p3),
                                         .init(prompt: "Dark moody aesthetic, wise old japanese samurai with a long white beard", image: .p4),
                                         .init(prompt: "A statue from a muscular greek god statue, dark marble", image: .p5)]
}
