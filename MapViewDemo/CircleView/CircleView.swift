//
//  CircleView.swift
//  MapViewDemo
//
//  Created by Nhan Tran D on 6/26/19.
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

