// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let responseModel = try? JSONDecoder().decode(ResponseModel.self, from: jsonData)

import Foundation

// MARK: - ResponseModel
struct ResponseModel: Codable {
    let artifacts: [Artifact]?
}

// MARK: - Artifact
struct Artifact: Codable {
    let base64: String?
    let seed: Int?
    let finishReason: String?
}
