//
//  PSIIndexSGTests.swift
//  PSIIndexSGTests
//
//  Created by klooma developer on 07/08/2018.
//  Copyright © 2018 Dan Navarez. All rights reserved.
//

import Quick
import Nimble



@testable import PSIIndexSG

class PSIIndexSGTests: QuickSpec {
    
    
    
    override func spec() {
        var psiModel: PSIModel!
        
        describe("Initialize PSIModel") {
            
            RestApiServices.cancelAllRequest(completion: {
                RestApiServices.getSGPSIIndex(completion: { (model) in
                    psiModel = model
                })
            })
            
            it("should fill psiModel from API and not should be nil") {
                expect(psiModel).toEventuallyNot(beNil(), timeout: 5)
            }
            
            it("should have list of regions") {
                expect(psiModel.regionMetadata?.count).to(equal(6))
            }
            
            it("should have the regions needed") {
                let regionList = ["west","national","east","central","south","north"]
                let regions = Dictionary(grouping: psiModel.regionMetadata!, by: { (regionAttributes) -> String in
                    return regionAttributes.name!
                })
                
                let keys = regions.keys
                expect(keys).to(contain(regionList))
            }
            
            it("should have list of items") {
                expect(psiModel.items?.count).to(equal(1))
            }
            
            
            it("should have reading indexes property values") {
                let item = psiModel.items?.first
                var readingAttr:ReadingAttributes?
                readingAttr = item?.readings
                
                // This will retrieve ReadingAttributes propertie and there corresponding values/data
                let mirror = Mirror(reflecting: readingAttr!)
                
                mirror.children.forEach({ (property) in
                    expect(property.label).toNot(beNil())
                })
                
            }
        }
    }
    
    
}
