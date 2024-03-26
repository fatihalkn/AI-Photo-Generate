// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let postModel = try? JSONDecoder().decode(PostModel.self, from: jsonData)

import Foundation

struct PostModel: Codable {
    var height: Int?
    var width: Int?
    var samples: Int?
    var steps: Int?
    var cfgScale: Int?
    var seed: Int?
    var stylePreset: String?
    var textPrompts: [TextPrompt]?
    
    enum CodingKeys: String, CodingKey {
        case height, width, samples, steps
        case textPrompts = "text_prompts"
        case stylePreset = "style_preset"
    }
}

// MARK: - TextPrompt
struct TextPrompt: Codable {
    var text: String?
    var weight: Int?
}
