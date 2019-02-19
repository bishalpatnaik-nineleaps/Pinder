////
////  ApiCallWrapper.swift
////  pinder
////
//  Created by Nineleaps on 15/02/19.
//  Copyright © 2019 Nineleaps. All rights reserved.
//

import UIKit
import Alamofire
import  Foundation



let baseURL = URL(string: "http://ec2-3-91-83-117.compute-1.amazonaws.com:3000/")
let login = URL(string: "login", relativeTo: baseURL)
let logout = URL(string: "logout", relativeTo: baseURL)
let likedPets = URL(string: "pets/likes", relativeTo: baseURL)
let retriveAllPets = URL(string: "pets", relativeTo: baseURL)

struct apiCallWrapper {

    static let sharedInstance = apiCallWrapper()

    public func requestForLoginDataWith(_ url: String,parameters: Parameters?, headers: HTTPHeaders? ,completion: @escaping ((DataResponse<LoginResponse>)) -> (Void)){
//        //let Url = URL(string: "\(url)")
        var urlString = baseURL
        var method: HTTPMethod = .post
        var header: HTTPHeaders? = ["":""]
        switch url {
        case "login":
            urlString = login!
            method = .post
            header = nil
            break
        case "logout":
            urlString = logout!
            method = .post
            header = nil
            break
        default:
            print("unknown request")
        }
        
        Alamofire.request(urlString! ,method: method , parameters: parameters , encoding: JSONEncoding.default ,headers: header).responseObject { (response: DataResponse<LoginResponse>) in
            
            completion(response)
        }

 }
    public func requestForPetDataWith(_ casetype: String, _ url: String,parameters: Parameters?, headers: HTTPHeaders? , completion: @escaping ((DataResponse<PetResponse>)?) -> (Void?)){
        var urlString = URL(string: url, relativeTo: baseURL)
        var method: HTTPMethod = .post
    switch casetype {
    case "likedPets":
    method = .get
    break
    case "updateLikedPets":
    method = .put
    break
    case "retriveAllPets":
    urlString = retriveAllPets!
    method  = .get
    break
    default:
        return
        }
        
        Alamofire.request(urlString! ,method: method , parameters: parameters , encoding: JSONEncoding.default ,headers: headers).responseObject { (response: DataResponse<PetResponse>) in
            print(response.response)
            completion(response)
            
        }
 }
    
    
}
























//
//
//        switch (url){
//        case "Login":
//            Alamofire.request(Login! ,method:.post , parameters: parameters , encoding: JSONEncoding.default ,headers: nil).responseObject { (response: DataResponse<LoginResponse>) in
//
//                    completion(response)
//            }
//            break
////        case "logout": Alamofire.request(logoutURL ,method:.post , parameters: nil , encoding: JSONEncoding.default ,headers: nil).responseObject { (response: DataResponse<ImageFullResponse>) in
////            let temp1 : String = (response.result.value.unsafelyUnwrapped.response?.imageStatus?.code)!
////            //  return temp1
////        }
////            break
////        case "retrieveAllPets":
////            Alamofire.request(getAllPetsURL ,method:.get , parameters: nil , encoding: JSONEncoding.default ,headers: nil).responseObject { (response: DataResponse<ImageFullResponse>) in
////                return response
////            }
////            break
////        case "retrieveLikedPets":
////            Alamofire.request(getLikedPetsURL ,method:.get , parameters: nil , encoding: JSONEncoding.default ,headers: nil).responseObject { (response: DataResponse<ImageFullResponse>) in
////                return response
////            }
////            break
////        case "updateLikePets":
////            Alamofire.request(updateLikedPetsURL ,method:.put , parameters: parameters ,  encoding: JSONEncoding.default ,headers: nil).responseObject { (response: DataResponse<ImageFullResponse>) in
////                return response
////            }
////            break
//        default: return
//        }
////                var result = [Pets]()
////                Alamofire.request(urlString, method: method, encoding: JSONEncoding.default, headers: header).responseObject()
////                    {(response: DataResponse<PetResponse>) in
////                     print("Status Code: \(response.response?.statusCode)")
////                        print(response)
////                        if response.response?.statusCode == 200 {
////                            if let responseresult = response.result.value {
////                                result = (responseresult.petResponseClass?.petData?.pets)!
////                            }
////                        }
////                }
////        completionHandler(result) // return data & close
//    }
