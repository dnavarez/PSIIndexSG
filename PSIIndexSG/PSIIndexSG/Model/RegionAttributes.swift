//
//  RegionMetadata.swift
//  PSIIndexSG
//
//  Created by klooma developer on 03/08/2018.
//  Copyright © 2018 Dan Navarez. All rights reserved.
//

import ObjectMapper

class RegionAttributes: Mappable {
    var name: String?
    var labelLocation: LabelLocationAttributes?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        labelLocation <- map["label_location"]
    }
}

class LabelLocationAttributes: Mappable {
    var latitude: Double?
    var longitude: Double?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
}
