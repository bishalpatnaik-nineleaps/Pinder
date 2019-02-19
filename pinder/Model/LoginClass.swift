//
//  LoginClass.swift
//  pinder
//
//  Created by Nineleaps on 11/02/19.
//  Copyright © 2019 Nineleaps. All rights reserved.
//
import Foundation
import ObjectMapper

class LoginResponse: Mappable {
    var response: ResponseClass?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        response <- map["response"]
    }
}

class ResponseClass: Mappable {
    var data: Data?
    var rstatus: Status?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        data <- map["data"]
        rstatus <- map["status"]
    }
}

class Data: Mappable {
    var rtoken: String?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        rtoken <- map["token"]
    }
}

class Status : Mappable {
    var rcode: String?
    var rmessage: String?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        rcode <- map["code"]
        rmessage <- map["message"]
    }
}
