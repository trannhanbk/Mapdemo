//
//  MapViewController.swift
//  MapViewDemo
//
//  Created by Nhan Tran D on 6/13/19.
//  Copyright © 2019 MBA0145. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import UserNotifications

final class MapViewController: UIViewController {}
//
//    @IBOutlet weak var mapView: MKMapView!
//
//    let locationManager = CLLocationManager()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configMapVieMapViewController private func configMapView() {
//        locationManager.delegate = self
//        mapView.delegate = self
//        mapView.userTrackingMode = .follow
//        let annotations = LocationStorage.shared.locations.map { annotationForLocation($0) }
//        mapView.addAnnotations(annotations)
//        NotificationCenter.default.addObserver(self, selector: #selector(newLocationAdded(_:)), name: .newLocationSaved, object: nil)
//    }
//
//    func annotationForLocation(_ location: Location) -> MKAnnotation {
//        let annotation = MKPointAnnotation()
//        annotation.title = location.dateString
//        annotation.coordinate = location.coordinates
//        return annotation
//    }
//
//    @objc func newLocationAdded(_ notification: Notification) {
//        guard let location = notification.userInfo?["location"] as? Location else {
//            return
//        }
//
//        let annotation = annotationForLocation(location)
//        mapView.addAnnotation(annotation)
//    }
//
//    @IBAction func addButtonTouchUpInside(_ sender: Any) {
//        guard let currentLocation = mapView.userLocation.location else {
//            return
//        }
//        print(currentLocation.coordinate)
//        LocationStorage.shared.saveCLLocationToDisk(currentLocation)
//    }
//
//    @objc func longpress(gestureRecognizer: UIGestureRecognizer){
//        let touchPoint = gestureRecognizer.location(in: self.mapView)
//        let coord = mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = coord
//        annotation.title = "Point X"
//        mapView.addAnnotation(annotation)
//        print(coord.latitude)
//        print(coord.longitude)
////
////        var lastLocation = locationManager.location      //last location
////        var currentLocation = locationManager.location   //current location
////
////
////        if locationSet == false {
////
////            let firstLocation = locationManager.location  //first point
////
////            locationSet = true
////
////        }
////
////        else {  //after second point
////
////            let currentLocation: CLLocation = locationManager.location ?? <#default value#>
////
////            var locations = [lastLocation, currentLocation]
////            var coordinates = locations.map({(location: CLLocation) -> CLLocationCoordinate2D in return location.coordinate})
////
////
////            var polyline = MKPolyline(coordinates: coordinates, count: locations.count)
////        }
//    }
//}
//
//extension MapViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        let renderer = MKPolylineRenderer(overlay: overlay)
//        renderer.strokeColor = .red
//        renderer.lineWidth = 4.0
//        return renderer
//    }
//}
//
//extension MapViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let longPressRec = UILongPressGestureRecognizer(target: self,
//                                                        action: #selector(MapViewController.longpress(gestureRecognizer:)))
//        longPressRec.minimumPressDuration = 1.5   //time for pressing : seconds
//        mapView.addGestureRecognizer(longPressRec)
//    }
//}
