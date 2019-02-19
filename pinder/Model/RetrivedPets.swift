//
//  RetrivedPets.swift
//  pinder
//
//  Created by Nineleaps on 12/02/19.
//  Copyright © 2019 Nineleaps. All rights reserved.
//

import Foundation
import ObjectMapper

class PetResponse: Mappable {
    var petResponseClass: PetResponseClass?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        petResponseClass <- map["response"]
    }
}

class PetResponseClass: Mappable {
    var petData: PetData?
    var rstatus: Status?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        petData <- map["data"]
        rstatus <- map["status"]
    }
    
}

class PetData: Mappable {
    var pets: [Pets]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        pets <- map["pets"]
    }
}

class Pets: Mappable {
    var id: String?
    var image: String?
    var name: String?
    var liked: Bool?
    var description: String?
    var version: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["_id"]
        image <- map["image"]
        name <- map["name"]
        liked <- map["liked"]
        description <- map["description"]
        version <- map["__v"]
    }
    
}

class PetStatus : Mappable {
    var rcode: String?
    var rmessage: String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        rcode <- map["code"]
        rmessage <- map["message"]
        
    }
}
