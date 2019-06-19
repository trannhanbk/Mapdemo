//
//  ImageViewController.swift
//  MapViewDemo
//
//  Created by Nhan Tran D on 6/17/19.
//  Copyright © 2019 MBA0145. All rights reserved.
//

import UIKit
import MapKit
import CoreGraphics

class ImageViewController: UIViewController {

    @IBOutlet private weak var drawingView: UIView!

    var isDrawing = false
    var lastPoint: CGPoint!
    var strokeColor: CGColor = UIColor.black.cgColor
    var strokes = [Stroke]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
//
//    override func loadView() {
//        super.loadView()
//        self.view = drawingView
//    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isDrawing else { return }
        isDrawing = true
        guard let touch = touches.first else { return }
        let currentPoint = touch.location(in: self.view)
//        lastPoint = currentPoint
//        print(currentPoint)

    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard isDrawing else {
//            return
//        }
        guard let touch = touches.first else { return }
        let currentPoint = touch.location(in: self.view)
//        let stroke = Stroke(startPoint: lastPoint, endPoint: currentPoint, color: strokeColor)
//        strokes.append(stroke)
//        lastPoint = currentPoint
        print(currentPoint)
        drawingLine(currentPoint)
    }

    private func drawingLine(_ point: CGPoint) {
        drawingView.draw(CGRect(origin: point, size: CGSize(width: 10, height: 10)))
    }
}
