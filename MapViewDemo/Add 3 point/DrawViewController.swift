//
//  DrawViewController.swift
//  MapViewDemo
//
//  Created by Nhan Tran D on 6/19/19.
//  Copyright © 2019 MBA0145. All rights reserved.
//

import UIKit

final class DrawViewController: UIViewController {

    var firstView = UIView()
    var secondView = UIView()
    var thirdView = UIView()
    var panGesture  = UIPanGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        configView(Dummy.pointFirstView, drawView: firstView)
        configView(Dummy.pointSeconView, drawView: secondView)
        configView(Dummy.pointThirdView, drawView: thirdView)
        addLine(start: firstView.center, end: secondView.center)
        addLine(start: secondView.center, end: thirdView.center)
    }

    private func configView( _ point: CGPoint, drawView: UIView) {
        let x = point.x - 10
        let y = point.y - 10
        let pointLocation = CGPoint(x: x, y: y)
        drawView.frame = CGRect(origin: pointLocation, size: CGSize(width: 20, height: 20))
        drawView.backgroundColor = .blue
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_:)))
        drawView.isUserInteractionEnabled = true
        drawView.addGestureRecognizer(panGesture)
        self.view.addSubview(drawView)
    }

    @objc func draggedView(_ sender: UIPanGestureRecognizer) {
        self.view.bringSubviewToFront(firstView)
        let translation = sender.translation(in: self.view)
        firstView.center = CGPoint(x: firstView.center.x + translation.x,
                                      y: firstView.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        if sender.state == .began {
            removeLine(start: secondView.center, end: firstView.center)
        } else if sender.state == .ended {
            addLine(start: secondView.center, end: firstView.center)
        }
    }

    private func removeLine(start: CGPoint, end: CGPoint) {
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 9.0
        shapeLayer.path = path.cgPath
        view.layer.addSublayer(shapeLayer)
    }

    private func addLine(start: CGPoint, end: CGPoint) {
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 3.0
        shapeLayer.path = path.cgPath
        view.layer.addSublayer(shapeLayer)

        print("===========\(distance(start, end))")
    }

    func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return CGFloat(sqrt(xDist * xDist + yDist * yDist))
    }
}

extension DrawViewController {
    struct Dummy {
        static let pointFirstView: CGPoint = {
            return CGPoint(x: UIScreen.main.bounds.width / 2, y: 200)
        }()

        static let pointSeconView: CGPoint = {
            return CGPoint(x: UIScreen.main.bounds.width / 2, y: 400)
        }()

        static let pointThirdView: CGPoint = {
            return CGPoint(x: UIScreen.main.bounds.width / 2, y: 600)
        }()
    }
}
