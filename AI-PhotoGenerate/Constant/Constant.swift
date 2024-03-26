//
//  Constant.swift
//  TextToSticker
//
//  Created by Fatih on 16.03.2024.

//let url = "https://api.stability.ai/v1/generation/stable-diffusion-xl-1024-v1-0/text-to-image"
//let headers: HTTPHeaders = [
    //"Accept": "application/json",
    //"Authorization": "Bearer sk-eBbCy0XXuidc6BjeVdIbu4FzSy0xfRkUAUObSCg8XXSJhoDv"


import Foundation
import UIKit
import Alamofire

final class Constant: UIViewController {
    
   
    enum ServiceEndPoint: String {
        case baseURL = "https://api.stability.ai/v1/generation/stable-diffusion-xl-1024-v1-0/text-to-image"
        
        static func imageServiceEndPoint() -> String {
            "\(baseURL)"
        }
    }
}

