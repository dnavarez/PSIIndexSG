//
//  ApiInfoAttribute.swift
//  PSIIndexSG
//
//  Created by klooma developer on 03/08/2018.
//  Copyright © 2018 Dan Navarez. All rights reserved.
//

import ObjectMapper

class ApiInfoAttribute: Mappable {
    var status: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
    }
}
