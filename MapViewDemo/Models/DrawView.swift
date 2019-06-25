//
//  DrawView.swift
//  MapViewDemo
//
//  Created by Nhan Tran D on 6/17/19.
//  Copyright © 2019 MBA0145. All rights reserved.
//

import CoreGraphics
import UIKit

protocol DrawViewDelegate: class {
    func view(view: DrawView, action: DrawView.Action)
}

class DrawView: ShadowView {

    enum Action {
        case changePoint(point: CGPoint)
        case draw
    }

    weak var delegate: DrawViewDelegate?

    var isDrawing = false
    var lastPoint: CGPoint!
    var strokeColor: CGColor = UIColor.black.cgColor
    var strokes = [Stroke]()

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isDrawing else { return }
        isDrawing = true
        guard let touch = touches.first else { return }
        let currentPoint = touch.location(in: self)
        lastPoint = currentPoint
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else {
            return
        }
//        isDrawing = false
//        guard strokes.count < 3 else {
//            return
//        }

        guard let touch = touches.first else { return }
        let currentPoint = touch.location(in: self)
        let stroke = Stroke(start: lastPoint, end: currentPoint, color: strokeColor)
        strokes.append(stroke)
        lastPoint = currentPoint
        configButtonInLocationPoint(lastPoint)
        delegate?.view(view: self, action: .changePoint(point: currentPoint))
    }

    override func draw(_ rect: CGRect) {
        drawingLineWhenChangePointLocation()
        delegate?.view(view: self, action: .draw)
    }

    func drawingLineWhenChangePointLocation() {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(4)
        context?.setLineCap(.round)
        for stroke in strokes {
            context?.beginPath()
            context?.move(to: stroke.start)
            context?.addLine(to: stroke.end)
            context?.setStrokeColor(stroke.color)
            context?.strokePath()
        }
    }

    func configButtonInLocationPoint(_ point: CGPoint) {
        let x = point.x - 10
        let y = point.y - 20
        let pointLocation = CGPoint(x: x, y: y)
        let viewDraw = UIView(frame: CGRect(origin: pointLocation, size: CGSize(width: 20, height: 20)))
        viewDraw.backgroundColor = .blue
        self.isUserInteractionEnabled = true
        viewDraw.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(movePoint)))
        self.addSubview(viewDraw)
    }

    @objc func movePoint(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        print("-=========================\(translation)=============================-")
    }
}


struct Stroke {
    var start: CGPoint
    var end: CGPoint
    let color: CGColor
}


class ShadowView: UIView {
    override func awakeFromNib() {
        layer.shadowOpacity = 1
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowPath = CGPath(rect: bounds, transform: nil)
    }
}
