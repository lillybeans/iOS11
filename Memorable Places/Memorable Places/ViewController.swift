//
//  ViewController.swift
//  Memorable Places
//
//  Created by Lilly Tong on 2017-10-14.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation //for user location

//this is our MAP view
class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{ //for map, user location

    @IBOutlet var map: MKMapView!
    
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(activePlace) //passed as a global variable from PlacesViewController
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longpress(gestureRecognizer:)))
        uilpgr.minimumPressDuration = 1
        map.addGestureRecognizer(uilpgr)
        
        if activePlace == -1 { //if no activeplace selected when we enter the map, then we check for user's location
            
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
            
        
        } else { //user clicked on an active place, let's check for that active place
            if places.count > activePlace { //to make sure no out of bounds error
                if let name = places[activePlace]["name"] {
                    if let lat = places[activePlace]["lat"] {
                        if let lon = places[activePlace]["lon"] {
                            if let latitude = Double(lat) { //lat is string, need convert
                                if let longitude = Double(lon) {//lon is string, need convert
                            
                                    //coordinate, span, region
                                    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                                    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) //range
                                    let region = MKCoordinateRegion(center: coordinate, span: span)
                                    
                                    map.setRegion(region, animated: true)
                                    
                                    let annotation = MKPointAnnotation()
                                    annotation.coordinate = coordinate //where to place this annotation
                                    annotation.title = name
                                    
                                    map.addAnnotation(annotation)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //remember locations is an array! must use locations[0]
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        self.map.setRegion(region, animated: true)
        
        
        
    }
    
    @objc func longpress(gestureRecognizer: UIGestureRecognizer){
        
        //prevent multiple long presses from being registered (i.e. if someone presses down for 4 secs)
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            
            let touchPoint = gestureRecognizer.location(in: map) //identify where user pressed
            let newCoordinate = self.map.convert(touchPoint,toCoordinateFrom: map)
            let location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude) //for geocoder
            var title = ""
            print(newCoordinate)
            
            //convert user-pressed coordinate into address
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                if error != nil {
                    print (error!)
                } else {
                    if let placemark = placemarks?[0] { //remember system may detect multiple locations in placemarks
                        if placemark.subThoroughfare != nil {
                            title += placemark.subThoroughfare! + " "
                        }
                        
                        if placemark.thoroughfare != nil {
                            title += placemark.thoroughfare!
                        }
                    }
                }
                
                if title == "" { //if no info
                    
                    title = "Added \(NSDate())" //just add date
                }
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = newCoordinate
                annotation.title = title
                
                self.map.addAnnotation(annotation)
                places.append(["name":title,"lat":String(newCoordinate.latitude),"lon":String(newCoordinate.longitude)]) //add to our places so it will show up in our list/table
                
                UserDefaults.standard.set(places,forKey:"places") //update permanent storage
                
                print(places)
            })
            

        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

