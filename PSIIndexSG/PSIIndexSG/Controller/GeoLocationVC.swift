//
//  FirstViewController.swift
//  PSIIndexSG
//
//  Created by klooma developer on 03/08/2018.
//  Copyright © 2018 Dan Navarez. All rights reserved.
//

import UIKit
import GoogleMaps

class GeoLocationVC: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var indexesButton: UIButton!
    
    var locationManager = CLLocationManager()
    var markers: [GMSMarker]?
    var zoomLevel: Float = 10.8
    var psiIndexes: NSDictionary?
    var psiModel: PSIModel?
    var psiSelectedKey: String?
    var isFirstLoad = true
    let alertSheet = UIAlertController(title: "Indexes", message: "", preferredStyle: .actionSheet)
    let appHelper = AppHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeProperties()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        appHelper.showLoadingInView(view: view, msg: "Loading...")
        fetchPSI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - METHODS -------------------------------------------------------------------------------
    func initializeProperties() {
        self.markers = []
        
        setupPSIIndexes()
        setupAlertSheet()
    }
    
    func setupPSIIndexes() {
        psiIndexes = [
            "o3_sub_index": ["O","3", " sub index"],
            "pm10_twenty_four_hourly": ["PM", "10", " 24 hourly"],
            "pm10_sub_index": ["PM", "10", " sub index"],
            "co_sub_index": ["CO sub index"],
            "pm25_twenty_four_hourly": ["PM", "25", " 24 hourly"],
            "so2_sub_index": ["SO", "2", " sub index"],
            "co_eight_hour_max": ["CO 8 hour max"],
            "no2_one_hour_max": ["NO", "2", " 1 hour max"],
            "so2_twenty_four_hourly": ["SO", "2", " 24 hourly"],
            "pm25_sub_index": ["PM", "25", " sub index"],
            "psi_twenty_four_hourly": ["PSI 24 hourly"],
            "o3_eight_hour_max": ["O", "3", " 8 hour max"]
        ]
        
        // set deault value for index
        psiSelectedKey = "o3_sub_index"
        let value = psiIndexes?.value(forKey: psiSelectedKey!)  as! [String]
        customizeButtonText(arrayText: value)
    }
    
    func setupAlertSheet() {
        for key in (psiIndexes?.allKeys)! {
            let value = psiIndexes?.value(forKey: key as! String)  as! [String]
            let text = value.joined()
            
            alertSheet.addAction(UIAlertAction(title: text, style: .default, handler: { (action) in
                print("select index = \(key)")
                
                self.appHelper.showLoadingInView(view: self.view, msg: "Updating...")
                self.view.layoutIfNeeded()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.psiSelectedKey = key as? String
                    self.customizeButtonText(arrayText: value)
                    self.fillIndexValue()
                    
                    self.appHelper.endLoading()
                })
            }))
        }
    }
    
    func customizeButtonText(arrayText: [String]) {
        let fontBig = UIFont.boldSystemFont(ofSize: 17)
        let fontSmall = UIFont.boldSystemFont(ofSize: 10)
        let color = UIColor(red: 0.075, green: 0.443, blue: 0.882, alpha: 1.00)
        let fullText = arrayText.joined()
        let attributedString = NSMutableAttributedString(string: fullText, attributes: nil)
        
        if arrayText.count == 1 {
            let bigRange = (attributedString.string as NSString).range(of: fullText)
            attributedString.setAttributes([NSAttributedStringKey.font: fontBig, NSAttributedStringKey.foregroundColor: color], range: bigRange)
        } else {
            let text1 = (attributedString.string as NSString).range(of: arrayText[0])
            let text2 = (attributedString.string as NSString).range(of: arrayText[1])
            let text3 = (attributedString.string as NSString).range(of: arrayText[2])
            
            attributedString.setAttributes([NSAttributedStringKey.font: fontBig, NSAttributedStringKey.foregroundColor: color], range: text1)
            attributedString.setAttributes([NSAttributedStringKey.font: fontSmall, NSAttributedStringKey.foregroundColor: color], range: text2)
            attributedString.setAttributes([NSAttributedStringKey.font: fontBig, NSAttributedStringKey.foregroundColor: color], range: text3)
        }
        
        indexesButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    func fetchPSI() {
        RestApiServices.getSGPSIIndex { (psiModel) in
            print(psiModel.toJSON())
            
            self.psiModel = psiModel
            do {
                if self.isFirstLoad {
                    self.isFirstLoad = false
                    
                    // Since it's first time controller loaded, we plot marker on map
                    for regionAttr in psiModel.regionMetadata! {
                        self.setupMarker(regionAttr: regionAttr)
                    }
                    
                    // Let's get last region to zoom and move the camera
                    let lastRegion = psiModel.regionMetadata?.last
                    self.setupCameraPosition(region: lastRegion!)
                }
                
                // Fill index value on marker
                self.fillIndexValue()
                
                self.appHelper.endLoading()
            } catch {
            }
        }
    }
    
    func fillIndexValue() {
        
        let itemsAttr = psiModel?.items?.first
        var readingSubAttr:ReadingSubAttributes?
        
        switch psiSelectedKey {
        case "o3_sub_index":
            readingSubAttr = itemsAttr?.readings?.o3SubIndex
        case "pm10_twenty_four_hourly":
            readingSubAttr = itemsAttr?.readings?.pm10TwentyFourHourly
        case "pm10_sub_index":
            readingSubAttr = itemsAttr?.readings?.pm10SubIndex
        case "co_sub_index":
            readingSubAttr = itemsAttr?.readings?.coSubIndex
        case "pm25_twenty_four_hourly":
            readingSubAttr = itemsAttr?.readings?.pm25TwentyFourHourly
        case "so2_sub_index":
            readingSubAttr = itemsAttr?.readings?.so2SubIndex
        case "co_eight_hour_max":
            readingSubAttr = itemsAttr?.readings?.coEightHourMax
        case "no2_one_hour_max":
            readingSubAttr = itemsAttr?.readings?.no2OneHourMax
        case "so2_twenty_four_hourly":
            readingSubAttr = itemsAttr?.readings?.so2TwentyFourHourly
        case "pm25_sub_index":
            readingSubAttr = itemsAttr?.readings?.pm25SubIndex
        case "psi_twenty_four_hourly":
            readingSubAttr = itemsAttr?.readings?.psiTwentyFourHourly
        case "o3_eight_hour_max":
            readingSubAttr = itemsAttr?.readings?.o3EightHourMax
        default:
            return
        }
        
        for marker in markers! {
            let markerView = marker.iconView as! MarkerView
            let location = markerView.locationLabel.text
            
            let mirror = Mirror(reflecting: readingSubAttr!)
            let value = mirror.children.first { $0.label == location }?.value ?? 0
            let intValue = value as! Int
            
            markerView.indexLabel.text = "\(intValue)"
        }
    }
    
    func setupCameraPosition(region: RegionAttributes) {
        let camera = GMSCameraPosition.camera(withLatitude: (region.labelLocation?.latitude)!,
                                              longitude: (region.labelLocation?.longitude)!,
                                              zoom: self.zoomLevel)
        self.mapView?.animate(to: camera)
    }
    
    func setupMarker(regionAttr: RegionAttributes) {
        
        let marker = GMSMarker()
        let markerView = Bundle.main.loadNibNamed("MarkerView", owner: self, options: nil)![0] as! MarkerView
        markerView.locationLabel.text = regionAttr.name
        
        marker.position = CLLocationCoordinate2D(latitude: (regionAttr.labelLocation?.latitude)!, longitude: (regionAttr.labelLocation?.longitude)!)
        marker.title = ""
        marker.snippet = ""
        marker.map = mapView
        marker.iconView = markerView
        
        self.markers?.append(marker)
    }


    
    // MARK: - EVENTS --------------------------------------------------------------------------------
    
    @IBAction func indexesButtonAction(_ sender: Any) {
        present(alertSheet, animated: true, completion: nil)
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        appHelper.showLoadingInView(view: view, msg: "Refreshing...")
        fetchPSI()
    }
}

