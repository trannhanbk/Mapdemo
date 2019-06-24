//
//  DrawLineViewController.swift
//  MapViewDemo
//
//  Created by Nhan Tran D on 6/20/19.
//  Copyright © 2019 MBA0145. All rights reserved.
//

import UIKit

final class DrawLineViewController: UIViewController {

    var panGesture  = UIPanGestureRecognizer()
    var drawViews: [UIView] = []

    var currentView = TapView()

    var isDrawing = false

    let path = UIBezierPath()
    let shapeLayer = CAShapeLayer()
    var strokeColor: CGColor = UIColor.black.cgColor

    var lastPoint: CGPoint!
    var tag = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        currentView.delegate = self
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
        configView(currentPoint, drawView: currentView, tag: tag)
        lastPoint = currentPoint
        drawViews.append(currentView)
        currentView.tag = tag
        tag += 1
        addLine(start: lastPoint, end: currentPoint)
        print("---------\(drawViews)-----------------\(currentPoint)--------------------------------------")
        print("............==========\(tag)======\(currentView.tag)=======")
    }

    private func configView( _ point: CGPoint, drawView: UIView, tag: Int) {
        let x = point.x - 10
        let y = point.y - 10
        let pointLocation = CGPoint(x: x, y: y)
        let drawView = UIView(frame: CGRect(origin: pointLocation, size: CGSize(width: 20, height: 20)))
        drawView.backgroundColor = .blue
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_:)))
        drawView.isUserInteractionEnabled = true
        drawView.addGestureRecognizer(panGesture)
        drawView.tag = tag
        drawViews.append(drawView)
        self.view.addSubview(drawView)
    }

    @objc func draggedView(_ sender: UIPanGestureRecognizer) {
        self.view.bringSubviewToFront(currentView)
        let translation = sender.translation(in: self.view)
        currentView.center = CGPoint(x: drawViews[currentView.tag].center.x + translation.x,
                                   y: drawViews[currentView.tag].center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
//        print("......................\(drawViews[currentView.tag])....................")
        print("......................\(currentView.tag).....\(drawViews[currentView.tag].tag)...............")
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

extension DrawLineViewController: TapViewDelegate {
    func view(view: TapView, action: TapView.Action) {
        switch action {
        case .tapMoved:
            print("...........oooooo........\(currentView.center.x)............00000.........")
        }
    }
}
