//
//  NewDrawLineViewController.swift
//  MapViewDemo
//
//  Created by Nhan Tran D on 6/24/19.
//  Copyright © 2019 MBA0145. All rights reserved.
//

import UIKit

class NewDrawLineViewController : UIViewController {

    var arrayCircleView: [CircleView] = []
    var index = 0
    let viewCircle = CircleView()

    var lastPoint: CGPoint!

    override func loadView() {
        viewCircle.backgroundColor = .white
        self.view = viewCircle
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let currentPoint = touch.location(in: self.view)
        lastPoint = currentPoint
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let currentPoint = touch.location(in: self.view)
        addViewInScreenWhenTouchEnd(point: currentPoint)
        index += 1
    }

    func addViewInScreenWhenTouchEnd(point: CGPoint) {
        let circleView = CircleView(frame: CGRect(origin: point, size: CGSize(width: 35, height: 35)))
        circleView.backgroundColor = .red

        viewCircle.addSubview(circleView)

        circleView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(didPan(gesture:))))
        arrayCircleView.append(circleView)

        if arrayCircleView.count > 1 && index >= 1 {
            viewCircle.layer.addSublayer(arrayCircleView[index - 1].lineTo(circle: arrayCircleView[index]))
        }
    }

    @objc func didPan(gesture: UIPanGestureRecognizer) {
        guard let circle = gesture.view as? CircleView else {
            return
        }
        if (gesture.state == .began) {
            circle.center = gesture.location(in: self.view)
        }
        let newCenter: CGPoint = gesture.location(in: self.view)
        let dX = newCenter.x - circle.center.x
        let dY = newCenter.y - circle.center.y
        circle.center = CGPoint(x: circle.center.x + dX, y: circle.center.y + dY)

        if let outGoingCircle = circle.outGoingCircle, let line = circle.outGoingLine, let path = circle.outGoingLine?.path {
            let newPath = UIBezierPath(cgPath: path)
            newPath.removeAllPoints()
            newPath.move(to: circle.center)
            newPath.addLine(to: outGoingCircle.center)
            line.path = newPath.cgPath
        }

        if let inComingCircle = circle.inComingCircle, let line = circle.inComingLine, let path = circle.inComingLine?.path {
            let newPath = UIBezierPath(cgPath: path)
            newPath.removeAllPoints()
            newPath.move(to: inComingCircle.center)
            newPath.addLine(to: circle.center)
            line.path = newPath.cgPath
        }
    }
}
