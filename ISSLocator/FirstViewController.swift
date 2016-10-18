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
import UserNotifications
/*
 
 *Required Features*:
 
 ******** Detect the user's current location - 1 hour -
 - Show the user the next time the ISS will pass over their location - 1 hour
 - Send the user a push notification when the ISS is overhead - 30 min
 
 */
class FirstViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let USER_DEFAULTS_NOTIFICATION = "USER_DEFAULTS_NOTIFICATION"
    
    var locationManager:CLLocationManager?
    var usersCurrentLocation:CLLocationCoordinate2D?
    var usersLocation:CLLocation?
    
    var receivedLocation:Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager = CLLocationManager()
        receivedLocation = false
        if CLLocationManager.authorizationStatus() == .notDetermined{
            locationManager?.requestAlwaysAuthorization()
        }
        
        
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.distanceFilter = 200
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        
        self.tableView.register(UINib(nibName:"ISSLocationTableViewCell", bundle:Bundle.main), forCellReuseIdentifier: "main")
    }
    
    //MARK: CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if receivedLocation == false {
            if let firstLocation = locations.first {
                receivedLocation = true
                usersLocation = firstLocation
                print("the users location is lat: \(usersLocation?.coordinate.latitude) and long: \(usersLocation?.coordinate.longitude)")
                let locationCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ISSLocationTableViewCell
                locationCell.latitudeLabel.text = "\((usersLocation?.coordinate.latitude)!)"
                locationCell.longitudeLabel.text = "\((usersLocation?.coordinate.longitude)!)"
                locationManager?.stopUpdatingLocation()
                self.getISSETA()
            }
        }
    }

    //MARK: Networking methods
    func getISSETA(){
        guard let lat = self.usersLocation?.coordinate.latitude else { return }
        guard let lon = self.usersLocation?.coordinate.longitude else { return }
        let issPassURL = "http://api.open-notify.org/iss-pass.json?lat=\(lat)&lon=\(lon)"
        
        Alamofire.request(issPassURL).responseJSON { response in
            print("call finished")
            
            let jsonData = JSON(response.result.value)
            let message = jsonData["message"].string
            if message == "success" {
                let responseJSONArray = jsonData["response"]
                
                for (_, subJSON): (String, JSON) in responseJSONArray {
                    let firstTimeStamp = subJSON["risetime"].doubleValue
                    let firstPassDate = Date(timeIntervalSince1970: firstTimeStamp)
                    let currentDate = Date(timeIntervalSinceNow: 0)
                    //determine difference between now and firstPassDate
                    var utcCalendar = NSCalendar.current
                    utcCalendar.timeZone = TimeZone(identifier: "UTC")!
                    
                    
                    let componentSet:Set<Calendar.Component> = [.day, .hour, .minute, .year, .second]
                    
                    let dateComponents = utcCalendar.dateComponents(componentSet, from: currentDate, to: firstPassDate)
                    let locationCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ISSLocationTableViewCell
                    
                    print ("time til first pass: \((dateComponents.day)!) d \((dateComponents.hour)!) h, \((dateComponents.minute)!) m  \((dateComponents.second)!) s")
                    
                    locationCell.visibilityLabel.text = "\((dateComponents.day)!)d \((dateComponents.hour)!)h \((dateComponents.minute)!)m \((dateComponents.second)!)s"
                    
                    let timeIntervalUntilPass = firstPassDate.timeIntervalSince(currentDate)
                    
                    
                    
                    UNUserNotificationCenter.current().requestAuthorization(
                        options: [.alert,.sound,.badge],
                        completionHandler: { (granted,error) in
                            let content = UNMutableNotificationContent()
                            content.title = "ISS Overhead!"
                            content.subtitle = "Look up!"
                            content.body = ""
                            content.categoryIdentifier = "message"
                            
                            let trigger = UNTimeIntervalNotificationTrigger(
                                timeInterval: timeIntervalUntilPass,
                                repeats: false)
                            
                            let request = UNNotificationRequest(
                                identifier: "notification.ISSOverhead",
                                content: content,
                                trigger: trigger
                            )
                            
                            UNUserNotificationCenter.current().add(
                                request, withCompletionHandler: nil)
                        }
                    )
                    
                    return
                }
            }
            
//
            
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
    
    //MARK: UITableView Delegate and Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let locationCell = tableView.dequeueReusableCell(withIdentifier: "main") as! ISSLocationTableViewCell
        
        //code to handle turning on and off local notifications. commented out for the moment. 
//        var userDefaultNotificationValue = UserDefaults.standard.value(forKey: USER_DEFAULTS_NOTIFICATION) as? NSNumber
//        if userDefaultNotificationValue == nil {
//            UserDefaults.standard.setValue(NSNumber(value: false), forKey: USER_DEFAULTS_NOTIFICATION)
//            userDefaultNotificationValue = NSNumber(value: false)
//        }
//        
//        if (userDefaultNotificationValue?.boolValue)! {
//            
//            locationCell.yesButton.layer.borderWidth = 3.0
//            locationCell.noButton.layer.borderWidth = 0.0
//        }else {
//            
//            locationCell.yesButton.layer.borderWidth = 0.0
//            locationCell.noButton.layer.borderWidth = 3.0
//        }
        
        return locationCell
    }
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height + 10
    }
}

