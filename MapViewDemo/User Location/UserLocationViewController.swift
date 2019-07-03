//
//  UserLocationViewController.swift
//  MapViewDemo
//
//  Created by Nhan Tran D on 6/26/19.
//  Copyright © 2019 MBA0145. All rights reserved.
//

import UIKit
import MapKit
import Contacts


class UserLocationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!


    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {

            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
}

extension UserLocationViewController: CLLocationManagerDelegate {


    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let userLocation = locations.last
        let viewRegion = MKCoordinateRegion(center: (userLocation?.coordinate)!, latitudinalMeters: 600, longitudinalMeters: 600)
        self.mapView.setRegion(viewRegion, animated: true)
    }


//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let newLocation = locations.last else {
//            return
//        }
//
//        guard let oldLocation = oldLocation else {
//            // Save old location
//            self.oldLocation = newLocation
//            return
//        }
//
//        let oldCoordinates = oldLocation.coordinate
//        let newCoordinates = newLocation.coordinate
//        var area = [oldCoordinates, newCoordinates]
//        let polyline = MKPolyline(coordinates: &area, count: area.count)
//        mapView.add(polyline)
//
//        // Save old location
//        self.oldLocation = newLocation
//    }
}

