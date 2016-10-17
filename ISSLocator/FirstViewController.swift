//
//  FirstViewController.swift
//  ISSLocator
//
//  Created by Corey Zanotti on 10/17/16.
//  Copyright © 2016 Corey Zanotti. All rights reserved.
//

import UIKit
import CoreLocation

/*
 
 *Required Features*:
 
 - Detect the user's current location - 1 hour
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
        }
    }


}

