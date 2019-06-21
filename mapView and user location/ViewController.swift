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
        addNewAnnotation()
    }
    
    func addNewAnnotation() {
        let Bhawarkua = MKPointAnnotation()
        Bhawarkua.title = "Bhawarkua"
        Bhawarkua.subtitle = "Bus Stop"
        Bhawarkua.coordinate = CLLocationCoordinate2D(latitude: 22.692501, longitude: 75.867449)
        mapView.addAnnotation(Bhawarkua)
    }
    
    func centerViewOnUserLocation() {
        if  let location = locationManager.location?.coordinate {
            let userCenter = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let region = MKCoordinateRegion(center: userCenter, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            mapView.setRegion(region, animated: true)
        }
    }
   

    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            //addNewAnnotation()
            beginLocationUpdates(locationManagerrr: locationManager)
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
    
    private func beginLocationUpdates(locationManagerrr: CLLocationManager) {
        mapView.showsUserLocation = true
        locationManagerrr.desiredAccuracy = kCLLocationAccuracyBest
        locationManagerrr.startUpdatingLocation()
    }
    
    func zoomToLatestLocation(with coordinate:CLLocationCoordinate2D) {
        let zoomRegion = MKCoordinateRegionMakeWithDistance(coordinate, 10000, 10000)
        mapView.setRegion(zoomRegion, animated: true)
    }
}

extension ViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let latestLocation = locations.first else { return }
//        if currentCoordinate == nil {
//            zoomToLatestLocation(with: latestLocation.coordinate)
//        }
//        currentCoordinate = latestLocation.coordinate
        }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
          var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "annotationView")
        }
        if let title = annotation.title, title == "Bhawarkua" {
            annotationView?.image = UIImage(named: "pin")
        }
            annotationView?.canShowCallout = true
            return annotationView
        }
    
}

    
    
    
    
    
    
    
    
    
    

  
    


















