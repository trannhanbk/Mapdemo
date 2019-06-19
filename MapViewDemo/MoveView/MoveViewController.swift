//
//  MoveViewController.swift
//  MapViewDemo
//
//  Created by Nhan Tran D on 6/18/19.
//  Copyright © 2019 MBA0145. All rights reserved.
//

import UIKit

class MoveViewController: UIViewController {

//    @IBOutlet private weak var viewDrag: UIView!

    var locationView = UIView()
    var panGesture  = UIPanGestureRecognizer()
    var isDrawing = false
    var lastPoint: CGPoint!
    var strokeColor: CGColor = UIColor.black.cgColor
    var strokes = [Stroke]()
    var isRemoveLine = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isDrawing else { return }
        isDrawing = true
        guard let touch = touches.first else { return }
        let currentPoint = touch.location(in: self.view)
        lastPoint = currentPoint
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else {
            return
        }

        guard let touch = touches.first else { return }
        let currentPoint = touch.location(in: self.view)
        let stroke = Stroke(start: lastPoint, end: currentPoint, color: strokeColor)
        strokes.append(stroke)
        lastPoint = currentPoint
        addLine()
        configView(currentPoint)
    }


    private func configView(_ point: CGPoint) {
        let x = point.x - 10
        let y = point.y - 10
        let pointLocation = CGPoint(x: x, y: y)
        locationView.frame = CGRect(origin: pointLocation, size: CGSize(width: 20, height: 20))
        locationView.backgroundColor = .blue
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_:)))
        locationView.isUserInteractionEnabled = true
        locationView.addGestureRecognizer(panGesture)
        self.view.addSubview(locationView)
    }

    @objc func draggedView(_ sender: UIPanGestureRecognizer) {
        self.view.bringSubviewToFront(locationView)
        let translation = sender.translation(in: self.view)
        locationView.center = CGPoint(x: locationView.center.x + translation.x,
                                      y: locationView.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        if sender.state == .ended {
            let pointLast = strokes[strokes.count - 1].start
            let stock = Stroke(start: pointLast, end: locationView.center, color: strokeColor)
            strokes.append(stock)
            lastPoint = locationView.center
            isRemoveLine = true
            addLine()
        }
    }

    func addLine() {
        for stock in strokes {
            //design the path
            let path = UIBezierPath()
            path.move(to: stock.start)
            path.addLine(to: stock.end)

            //design path in layer
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.strokeColor = UIColor.red.cgColor
            shapeLayer.lineWidth = 1.0
            if isRemoveLine {
                shapeLayer.removeAllAnimations()
                isRemoveLine = false
            }
            view.layer.addSublayer(shapeLayer)
        }
    }
}
