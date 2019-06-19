//
//  HomeViewController.swift
//  MapViewDemo
//
//  Created by Nhan Tran D on 6/13/19.
//  Copyright © 2019 MBA0145. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var mapView: UIView!
    let canvas = Canvas()

    override func loadView() {
        self.view = canvas
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        canvas.backgroundColor = .white
        canvas.setStrockeWidth(width: 4)
        canvas.setStrockeColor(color: .red)
    }

    private func configMapView() {
//        let location = mapView.userLocation
//        let point = mapView.projection.pointFromCoordinate(location.coordinate)
//        let pointInNewView = newView.convert(point, from: mapView)
    }

    
}
