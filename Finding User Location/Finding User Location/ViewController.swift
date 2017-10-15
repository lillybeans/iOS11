//
//  ViewController.swift
//  Finding User Location
//
//  Created by Lilly Tong on 2017-10-11.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit
import CoreLocation //1. need to import for CLLocationManagerDelegate to work
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate { //2. add delegate

    var locationManager = CLLocationManager()
    
    @IBOutlet var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self //allow ViewController to control locationManager
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //best uses more battery
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //this function gets called everytime location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0] //take first measurement
        /*
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        let latDelta:CLLocationDegrees = 0.05
        let lonDelta:CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta:latDelta, longitudeDelta:lonDelta)
        let location = CLLocationCoordinate2D(latitude:latitude,longitude:longitude)
        let region = MKCoordinateRegion(center: location, span: span)
        self.map.setRegion(region,animated:true)
         */
        
        //Geocoder: from lat/lon to address
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if error != nil { //if there's error
                print(error)
            } else {
                if let placemark = placemarks?[0] { //we don't know if locations (array) have been succcesfully converted,
                    var subThoroughfare = "" //can't use "if let" because we will always reference subThoroughFare
                    if placemark.subThoroughfare != nil {
                        subThoroughfare = placemark.subThoroughfare!
                    }
                    var thoroughfare = "" //can't use "if let" because we will always reference subThoroughFare
                    if placemark.thoroughfare != nil {
                        thoroughfare = placemark.thoroughfare!
                    }
                    
                    var subLocality = "" //can't use "if let" because we will always reference subThoroughFare
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
                    
                    print (subThoroughfare + " " + thoroughfare + "\n" + subLocality + "\n" + subAdministrativeArea +
                    "\n" + postalCode + "\n" + country + "\n")
                }
            
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

