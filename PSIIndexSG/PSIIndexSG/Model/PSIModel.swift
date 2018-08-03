//
//  PSIModel.swift
//  PSIIndexSG
//
//  Created by klooma developer on 03/08/2018.
//  Copyright © 2018 Dan Navarez. All rights reserved.
//

import ObjectMapper

class PSIModel: Mappable {
    var regionMetadata : [RegionAttributes]?
    var items : [ItemsAttributes]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        regionMetadata <- map["region_metadata"]
        items <- map["items"]
    }
}




