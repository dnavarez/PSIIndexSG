//
//  RestAPIServices.swift
//  FetchApp
//
//  Created by klooma developer on 03/08/2018.
//  Copyright © 2018 Dan Navarez. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

struct NetworkSettings {
    static var BASE_URL = "https://api.data.gov.sg/v1/environment/psi"
    static var NETWORK_HEADERS = ["Accept":"application/json"]
}

struct RestApiServices {
    
    static func getSGPSIIndex(completion: @escaping (_ response: PSIModel) -> Void) {
        let url = NetworkSettings.BASE_URL
        
        Alamofire.request(url).responseObject { (response: DataResponse<PSIModel>) in
            guard let psiModel = response.result.value else { return }
            completion(psiModel)
        }
    }
}
