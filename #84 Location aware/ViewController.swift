//
//  ViewController.swift
//  #84 Location aware
//
//  Created by Leo on 07/01/2018.
//  Copyright © 2018 Leo. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

//https://developer.apple.com/documentation/corelocation/choosing_the_authorization_level_for_location_services/requesting_always_authorization?language=objc

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet var map: MKMapView!
    @IBOutlet var longitube: UILabel!
    @IBOutlet var course: UILabel!
    @IBOutlet var speed: UILabel!
    @IBOutlet var altitube: UILabel!
    @IBOutlet var address: UILabel!
    
    
    @IBOutlet var latitube: UILabel!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self  //委派給ViewController
        locationManager.desiredAccuracy = kCLLocationAccuracyBest  //設定為最佳精度
        locationManager.requestWhenInUseAuthorization()  //user授權
        locationManager.startUpdatingLocation()  //開始update位置
        
        
        
        map.delegate = self
        map.showsUserLocation = true   //顯示user位置
        map.userTrackingMode = .follow  //隨著user移動
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //開啟update位置後 startUpdatingLocation()，觸發func locationManager, [CLLocation]會取得所有定位點，[0]為最新點
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //print(locations)
        let userLocation: CLLocation = locations[0]
 
        self.latitube.text = String(userLocation.coordinate.latitude)
        self.longitube.text = String(userLocation.coordinate.longitude)
        self.course.text = String(userLocation.course)
        self.speed.text = String(userLocation.speed)
        self.altitube.text = String(userLocation.altitude)
        
 
        
        //CLGeocoder地理編碼 經緯度轉換地址位置
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemark, error) in
            
            if error != nil {
                
                print(error)
                
            } else {
                
                //the geocoder actually returns CLPlacemark objects, which contain both the coordinate and the original information that you provided.
                if let placemark = placemark?[0] {
                    
                    //print(placemark)
                    var address = ""
                    
                    if placemark.subThoroughfare != nil {
                        
                        address += placemark.subThoroughfare! + " "
                        
                    }
                    
                    if placemark.thoroughfare != nil {
                        
                        address += placemark.thoroughfare! + "\n"
                        
                    }
                    
                    if placemark.subLocality != nil {
                        
                        address += placemark.subLocality! + "\n"
                        
                    }
                    
                    if placemark.subAdministrativeArea != nil {
                        
                        address += placemark.subAdministrativeArea! + "\n"
                        
                    }
                    
                    if placemark.postalCode != nil {
                        
                        address += placemark.postalCode! + "\n"
                        
                    }
                    
                    if placemark.country != nil {
                        
                        address += placemark.country!
                        
                    }
                    
                    self.address.text = String(address)
                }
                
            }
 
        }

        /*
        //連續點擊２次completionHandler 展開
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placermarks, error) in
            
            if error != nil {
                
                print(error)
                
            } else {
                
                if let placemark =  placermarks?[0] {
                    
                    var subThoroughfare = ""
                    
                    if placemark.subThoroughfare != nil {
                        
                        subThoroughfare = placemark.subThoroughfare!
                        
                    }
                    
                    var thoroughfare = ""
                    
                    if placemark.thoroughfare != nil {
                        
                        thoroughfare = placemark.thoroughfare!
                        
                    }
                    
                    var subLocality = ""
                    
                    if placemark.subLocality != nil {
                        
                        subLocality = placemark.subLocality!
                        
                    }
                    
                    var subAdministrativeArea = ""
                    
                    if placemark.subAdministrativeArea != nil {
                        
                        subAdministrativeArea = placemark.subAdministrativeArea!
                        
                    }
                    
                    var postalCode = ""
                    
                    if placemark.postalCode != nil {
                        
                        postalCode = placemark.postalCode!
                        
                    }
                    
                    var country = ""
                    
                    if placemark.country != nil {
                        
                        country = placemark.country!
                        
                    }
                    
                    
                    
                    print(subThoroughfare + thoroughfare + "\n" + subLocality + "\n" + subAdministrativeArea + "\n" + postalCode + "\n" + country)
                    
                    
                }
         
            }
 
        }
 */
    }

    
}

