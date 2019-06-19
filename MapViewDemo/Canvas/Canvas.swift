//
//  Canvas.swift
//  MapViewDemo
//
//  Created by Nhan Tran D on 6/14/19.
//  Copyright © 2019 MBA0145. All rights reserved.
//

import UIKit

class Canvas: UIView {

    private var strokeColor = UIColor.black
    private var strokeWidth: Float = 1

    private var lines = [Line]()

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard  let context = UIGraphicsGetCurrentContext() else { return }

        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineCap(.round)
            context.setLineWidth(CGFloat(line.strokeWidth))
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }

    func setStrockeWidth(width: Float) {
        self.strokeWidth = width
    }

    func setStrockeColor(color: UIColor) {
        self.strokeColor = color
    }

    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }

    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
}

struct Line {
    let strokeWidth: Float
    let color: UIColor
    var points: [CGPoint]
}
