//
//  FirstViewController.swift
//  ISSLocator
//
//  Created by Corey Zanotti on 10/17/16.
//  Copyright © 2016 Corey Zanotti. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

/*
 
 *Required Features*:
 
 ******** Detect the user's current location - 1 hour -
 - Show the user the next time the ISS will pass over their location - 1 hour
 - Send the user a push notification when the ISS is overhead - 30 min
 
 */
class FirstViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager?
    var usersCurrentLocation:CLLocationCoordinate2D?
    var usersLocation:CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager = CLLocationManager()
        
        if CLLocationManager.authorizationStatus() == .notDetermined{
            locationManager?.requestAlwaysAuthorization()
        }
        
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.distanceFilter = 200
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
    }
    
    //MARK: CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let firstLocation = locations.first {
            usersLocation = firstLocation
            print("the users location is lat: \(usersLocation?.coordinate.latitude) and long: \(usersLocation?.coordinate.longitude)")
            self.getISSETA()
        }
    }

    //MARK: Networking methods
    func getISSETA(){
        guard let lat = self.usersLocation?.coordinate.latitude else { return }
        guard let lon = self.usersLocation?.coordinate.longitude else { return }
        let issPassURL = "http://api.open-notify.org/iss-pass.json?lat=\(lat)&lon=\(lon)"
        
        Alamofire.request(issPassURL).responseJSON { response in
            print("call finished")
            
//            let jsonData = JSON(response.result.value!)
//            
//            print("JSON: \(jsonData)")
            //loop through each element in JSON and add to an array
//            var arrayForAdId = self.adEntryDictionary[searchBarText]
//            if arrayForAdId == nil {
//                arrayForAdId = [AppIdResponse]()
//            }
//            for (_, subJSON): (String, JSON) in jsonData {
//                let advertisingEntry = AppIdResponse(advertiserId: subJSON["advertiser_id"].string!, ymd: subJSON["ymd"].string!, numClicks: subJSON["num_clicks"].int!, numImpressions: subJSON["num_impressions"].int!)
//                arrayForAdId?.append(advertisingEntry)
//            }
            
            
        }
    }
}

