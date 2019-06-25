//
//  NewDrawLineViewController.swift
//  MapViewDemo
//
//  Created by Nhan Tran D on 6/24/19.
//  Copyright © 2019 MBA0145. All rights reserved.
//

import UIKit

class CircleView : UIView {

    var outGoingLine : CAShapeLayer?
    var inComingLine : CAShapeLayer?
    var inComingCircle : CircleView?
    var outGoingCircle : CircleView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = self.frame.size.width / 2
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func lineTo(circle: CircleView) -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: self.center)
        path.addLine(to: circle.center)

        let line = CAShapeLayer()
        line.path = path.cgPath
        line.lineWidth = 3
        line.strokeColor = UIColor.blue.cgColor
        circle.inComingLine = line
        outGoingLine = line
        outGoingCircle = circle
        circle.inComingCircle = self
        return line
    }
}

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




//import UIKit
//
//class MoveAbleView : UIView {
//    var outGoingLine : CAShapeLayer?
//    var inComingLine : CAShapeLayer?
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func lineTo(connectedView: MoveAbleView) -> CAShapeLayer {
//        let path = UIBezierPath()
//        path.move(to: self.center)
//        path.addLine(to: connectedView.center)
//
//        let line = CAShapeLayer()
//        line.path = path.cgPath
//        line.lineWidth = 5
//        line.strokeColor = UIColor.purple.cgColor
//        connectedView.inComingLine = line
//        outGoingLine = line
//        return line
//    }
//}
//
//class NewDrawLineViewController: UIViewController {
//    var dynamicAnimator = UIDynamicAnimator()
//    var collisionBehavior = UICollisionBehavior()
//    var gravityBehavior = UIGravityBehavior()
//
//    override func loadView() {
//
//        let view = UIView()
//        view.backgroundColor = .white
//        self.view = view
//        dynamicAnimator = UIDynamicAnimator(referenceView: view)
//
//        let viw = MoveAbleView(frame: CGRect(x: 100, y: 200, width: 50, height: 50))
//        viw.backgroundColor = UIColor.red
//        self.view.addSubview(viw)
//
//        let viw2 = MoveAbleView(frame: CGRect(x: 300, y: 200, width: 50, height: 50))
//        viw2.backgroundColor = UIColor.orange
//        self.view.addSubview(viw2)
//
//        let gravityViw = MoveAbleView(frame: CGRect(x: 100, y: 0, width: 50, height: 50))
//        gravityViw.backgroundColor = UIColor.green
//        self.view.addSubview(gravityViw)
//
//
//
//        let line1 = MoveAbleView(frame: CGRect(x: 125, y: 225, width: 200, height: 10))
//        line1.backgroundColor = UIColor.purple
//        self.view.addSubview(line1)
//
//
//        let l1 = UIAttachmentBehavior.init(item: viw, offsetFromCenter: UIOffset.zero, attachedTo: line1, offsetFromCenter: UIOffset.init(horizontal: -100, vertical: 0))
//        let l2 = UIAttachmentBehavior.init(item: viw2, offsetFromCenter: UIOffset.zero, attachedTo: line1, offsetFromCenter: UIOffset.init(horizontal: 100, vertical: 0))
//
//        collisionBehavior.addItem(viw)
//        collisionBehavior.addItem(viw2)
//        collisionBehavior.addItem(gravityViw)
//
//
//        gravityBehavior.addItem(gravityViw)
//
//        dynamicAnimator.addBehavior(l1)
//        dynamicAnimator.addBehavior(l2)
//
//        dynamicAnimator.addBehavior(collisionBehavior)
//        dynamicAnimator.addBehavior(gravityBehavior)
//
//
//
//
//


//        let view = UIView()
//        view.backgroundColor = .white
//        self.view = view
//
//        let viw = MoveAbleView(frame: CGRect(x: 100, y: 200, width: 50, height: 50))
//        viw.backgroundColor = UIColor.red
//        self.view.addSubview(viw)
//
//        let viw2 = MoveAbleView(frame: CGRect(x: 300, y: 100, width: 50, height: 50))
//        viw2.backgroundColor = UIColor.orange
//        self.view.addSubview(viw2)
//
//        let gravityViw = MoveAbleView(frame: CGRect(x: 100, y: 0, width: 50, height: 50))
//        gravityViw.backgroundColor = UIColor.green
//        self.view.addSubview(gravityViw)
//
//        let gravityViw2 = MoveAbleView(frame: CGRect(x: 300, y: -200, width: 50, height: 50))
//        gravityViw2.backgroundColor = UIColor.blue
//        self.view.addSubview(gravityViw2)
//
//        collisionBehavior.addItem(viw)
//        collisionBehavior.addItem(viw2)
//        collisionBehavior.addItem(gravityViw)
//        collisionBehavior.addItem(gravityViw2)
//
//        gravityBehavior.addItem(gravityViw)
//        gravityBehavior.addItem(gravityViw2)
//
//        dynamicAnimator.addBehavior(collisionBehavior)
//        dynamicAnimator.addBehavior(gravityBehavior)
//        self.view.layer.addSublayer(viw.lineTo(connectedView: viw2))
//    }
//}
