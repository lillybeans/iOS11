//
//  ViewController.swift
//  Maps
//
//  Created by Lilly Tong on 2017-10-10.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit
import MapKit //added by user

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let latitude : CLLocationDegrees = 43.6426
        let longitude: CLLocationDegrees = -79.3871
        let latDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let coordinates:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(coordinates, span)
        
        map.setRegion(region,animated:false)
        
        let annotation = MKPointAnnotation()
        annotation.title = "Toronto"
        annotation.subtitle = "Best city in the world!"
        annotation.coordinate = coordinates
        
        map.addAnnotation(annotation)
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longpress(gestureRecognizer:)))
        uilpgr.minimumPressDuration = 2
        map.addGestureRecognizer(uilpgr)
        
        
    }
    
    @objc func longpress(gestureRecognizer: UIGestureRecognizer){
        print("long pressed")
        let touchPoint = gestureRecognizer.location(in: map) //"self" since closure. touchPoint is where longpress happened on the map.
        let coordinate = map.convert(touchPoint, toCoordinateFrom: map) //convert touchpoint to coordinate from the map
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "New Place"
        annotation.subtitle = "Maybe I'd like to go here..."
        map.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

