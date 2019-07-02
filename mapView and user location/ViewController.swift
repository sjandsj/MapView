//  ViewController.swift
//  mapView and user location
//
//  Created by mac on 20/06/19.
//  Copyright © 2019 gammastack. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let regionInMeters:Double = 10000
    var currentCoordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
    }
    
    func addNewAnnotation() {
        let location = MKPointAnnotation()
        location.title = "Treasure Island"
        location.subtitle = "PVR"
        location.coordinate = CLLocationCoordinate2D(latitude: 22.721987, longitude: 75.878468)
        mapView.addAnnotation(location)
    }
    
    func centerViewOnUserLocation() {
        if  let location = locationManager.location?.coordinate {
            let userCenter = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let region = MKCoordinateRegion(center: userCenter, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            mapView.setRegion(region, animated: true)
        }
    }
   
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            addNewAnnotation()
            //beginLocationUpdates(locationManagerrr: locationManager)
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways:
            break
        }
    }
 
    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setUpLocationManager()
            checkLocationAuthorization()
            } else {
            setUpLocationManager()
        }
    }
}

extension ViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        print("Updating location")
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "annotationView")
        }
        if let title = annotation.title, title == "Treasure Island" {
            let t = CGRect(x: 0, y: 0, width: 50, height: 50)
            annotationView?.image?.draw(in: t)
            annotationView?.image = UIImage(named: "pin")
        }
            annotationView?.canShowCallout = true
            //annotationView?.calloutOffset = CGPoint
            return annotationView
        }
}

    
    
    
    
    
    
    
    
    
    

  
    


















