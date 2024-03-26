////
////  NetworkHelper.swift
////  TextToSticker
////
////  Created by Fatih on 16.03.2024.
////
//
//import Alamofire
//
//protocol NetworkHelperProtocol {
//    func creatPhoto(parameters:PostModel, header: HTTPHeader ,onSuccess: @escaping (ResponseModel?) -> (), onError : @escaping (AFError) -> ())
//}
//
//final class NetworkHelper: NetworkHelperProtocol {
//    static let shared = NetworkHelper()
//    func creatPhoto(parameters: PostModel, header: Alamofire.HTTPHeader, onSuccess: @escaping (ResponseModel?) -> (), onError: @escaping (Alamofire.AFError) -> ()) {
//        
//        let headers: HTTPHeaders = [
//            "Accept": "application/json",
//            "Authorization": "Bearer sk-eBbCy0XXuidc6BjeVdIbu4FzSy0xfRkUAUObSCg8XXSJhoDv"
//        ]
//        NetworkManager.shared.sendPostRequest(url: Constant.ServiceEndPoint.imageServiceEndPoint(), parameters: parameters, headers: headers) { (result: Result<ResponseModel, Error>) in
//            switch result {
//            case .success(let success):
//                onSuccess(success)
//            case .failure(let failure):
//                onError(failure as! AFError)
//            }
//        }
//    }
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
////    func creatPhoto(onSuccess: @escaping (PostModel?) -> (), onError: @escaping (Alamofire.AFError) -> ()) {
////        NetworkManager.shared.fetch(path: Constant.ServiceEndPoint.imageServiceEndPoint()) { (response: PostModel) in
////            onSuccess(response)
////        } onError: { error in
////            onError(error)
////        }
////
////    }
//    
//    
//}
