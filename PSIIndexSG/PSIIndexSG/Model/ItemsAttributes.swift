//
//  ItemsAttributes.swift
//  PSIIndexSG
//
//  Created by klooma developer on 03/08/2018.
//  Copyright © 2018 Dan Navarez. All rights reserved.
//

import ObjectMapper

class ItemsAttributes: Mappable {
    var timeStamp: String?
    var updateTimestamp: String?
    var readings: ReadingAttributes?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        timeStamp <- map["timestamp"]
        updateTimestamp <- map["update_timestamp"]
        readings <- map["readings"]
    }
}

class ReadingAttributes: Mappable {
    var o3SubIndex: ReadingSubAttributes?
    var pm10TwentyFourHourly: ReadingSubAttributes?
    var pm10SubIndex: ReadingSubAttributes?
    var coSubIndex: ReadingSubAttributes?
    var pm25TwentyFourHourly: ReadingSubAttributes?
    var so2SubIndex: ReadingSubAttributes?
    var coEightHourMax: ReadingSubAttributes?
    var no2OneHourMax: ReadingSubAttributes?
    var so2TwentyFourHourly: ReadingSubAttributes?
    var pm25SubIndex: ReadingSubAttributes?
    var psiTwentyFourHourly: ReadingSubAttributes?
    var o3EightHourMax: ReadingSubAttributes?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        o3SubIndex <- map["o3_sub_index"]
        pm10TwentyFourHourly <- map["pm10_twenty_four_hourly"]
        pm10SubIndex <- map["pm10_sub_index"]
        coSubIndex <- map["co_sub_index"]
        pm25TwentyFourHourly <- map["pm25_twenty_four_hourly"]
        so2SubIndex <- map["so2_sub_index"]
        coEightHourMax <- map["co_eight_hour_max"]
        no2OneHourMax <- map["no2_one_hour_max"]
        so2TwentyFourHourly <- map["so2_twenty_four_hourly"]
        pm25SubIndex <- map["pm25_sub_index"]
        psiTwentyFourHourly <- map["psi_twenty_four_hourly"]
        o3EightHourMax <- map["o3_eight_hour_max"]
    }
}

class ReadingSubAttributes: Mappable {
    var west: Int?
    var national: Int?
    var east: Int?
    var central: Int?
    var south: Int?
    var north: Int?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        west <- map["west"]
        national <- map["national"]
        east <- map["east"]
        central <- map["central"]
        south <- map["south"]
        north <- map["north"]
    }
}
