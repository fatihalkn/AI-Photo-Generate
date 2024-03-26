//
//  NetworkManager.swift
//  TextToSticker
//
//  Created by Fatih on 16.03.2024.
//

import Foundation
import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    func sendingPostRequest<T: Codable>(parameters: PostModel, handler: @escaping (_ result: T) -> Void ) {
        let url = "https://api.stability.ai/v1/generation/stable-diffusion-xl-1024-v1-0/text-to-image"
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer sk-rZdLP5H0dsKpuLVU2kPT4gGpd87TrJ2BFV4zyLCyw06E9IQG"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseJSON { response in
            print("Request Parameters: \(parameters)")
            switch response.result {
            case .success(let data):
                if let jsonData = try? JSONSerialization.data(withJSONObject: data) {
                    if let jsonDataString = String(data: jsonData, encoding: .utf8) {
                        print("JSON Data: \(jsonDataString)")
                    } else {
                        print("Failed to convert JSON data to string")
                    }
                    print("jsonData = \(jsonData)")
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
                        print("decodedData = \(decodedData)")
                        handler(decodedData)
                       
                    } catch {
                        print("Decoding error: \(error)")
                    }
                } else {
                    print("Invalid JSON data")
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }

    }
}
