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

    let path = UIBezierPath()
    let shapeLayer = CAShapeLayer()

    var point: [CGPoint] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configfirstView(Dummy.pointFirstView, drawView: firstView)
        configSecondView(Dummy.pointSeconView, drawView: secondView)
        configThirdView(Dummy.pointThirdView, drawView: thirdView)
        addLine(start: firstView.center, end: secondView.center)
        addLine(start: secondView.center, end: thirdView.center)
    }

    private func addLine(start: CGPoint, end: CGPoint) {
        path.move(to: start)
        path.addLine(to: end)
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 3.0
        shapeLayer.path = path.cgPath
        view.layer.addSublayer(shapeLayer)
    }
}

// Config first view
extension DrawViewController {
    private func configfirstView( _ point: CGPoint, drawView: UIView) {
        let x = point.x - 10
        let y = point.y - 10
        let pointLocation = CGPoint(x: x, y: y)
        drawView.frame = CGRect(origin: pointLocation, size: CGSize(width: 20, height: 20))
        drawView.backgroundColor = .blue
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedFirstView(_:)))
        drawView.isUserInteractionEnabled = true
        drawView.addGestureRecognizer(panGesture)
        self.view.addSubview(drawView)
    }

    @objc func draggedFirstView(_ sender: UIPanGestureRecognizer) {
        point.removeAll()
        self.view.bringSubviewToFront(firstView)
        let translation = sender.translation(in: self.view)
        firstView.center = CGPoint(x: firstView.center.x + translation.x,
                                   y: firstView.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        point.append(firstView.center)
        path.removeAllPoints()
        guard let point = point.last else { return }
        addLine(start: secondView.center, end: point)
        addLine(start: secondView.center, end: thirdView.center)
    }
}

// Config second view
extension DrawViewController {
    private func configSecondView( _ point: CGPoint, drawView: UIView) {
        let x = point.x - 10
        let y = point.y - 10
        let pointLocation = CGPoint(x: x, y: y)
        drawView.frame = CGRect(origin: pointLocation, size: CGSize(width: 20, height: 20))
        drawView.backgroundColor = .blue
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedSecondView(_:)))
        drawView.isUserInteractionEnabled = true
        drawView.addGestureRecognizer(panGesture)
        self.view.addSubview(drawView)
    }

    @objc func draggedSecondView(_ sender: UIPanGestureRecognizer) {
        point.removeAll()
        self.view.bringSubviewToFront(secondView)
        let translation = sender.translation(in: self.view)
        secondView.center = CGPoint(x: secondView.center.x + translation.x,
                                   y: secondView.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        point.append(secondView.center)
        path.removeAllPoints()
        guard let point = point.last else { return }
        addLine(start: firstView.center, end: point)
        addLine(start: point, end: thirdView.center)
    }
}

// Config third view
extension DrawViewController {
    private func configThirdView( _ point: CGPoint, drawView: UIView) {
        let x = point.x - 10
        let y = point.y - 10
        let pointLocation = CGPoint(x: x, y: y)
        drawView.frame = CGRect(origin: pointLocation, size: CGSize(width: 20, height: 20))
        drawView.backgroundColor = .blue
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedThirdView(_:)))
        drawView.isUserInteractionEnabled = true
        drawView.addGestureRecognizer(panGesture)
        self.view.addSubview(drawView)
    }

    @objc func draggedThirdView(_ sender: UIPanGestureRecognizer) {
        point.removeAll()
        self.view.bringSubviewToFront(thirdView)
        let translation = sender.translation(in: self.view)
        thirdView.center = CGPoint(x: thirdView.center.x + translation.x,
                                   y: thirdView.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        point.append(thirdView.center)
        path.removeAllPoints()
        guard let point = point.last else { return }
        addLine(start: secondView.center, end: point)
        addLine(start: firstView.center, end: secondView.center)
    }
}

extension DrawViewController {
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
