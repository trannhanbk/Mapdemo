//
//  PoinView.swift
//  MapViewDemo
//
//  Created by Nhan Tran D on 6/17/19.
//  Copyright © 2019 MBA0145. All rights reserved.
//

import Foundation

import UIKit

private let RADIUS: CGFloat = 5

class PointView: UIControl {

    class func aInstance() -> PointView {

        let aInstance = PointView(frame: CGRect(origin: .zero, size: CGSize(width: RADIUS * 2, height: RADIUS * 2)))
        aInstance.layer.cornerRadius = RADIUS
        aInstance.layer.masksToBounds = true
        aInstance.backgroundColor = UIColor.magenta
        aInstance.addTarget(aInstance, action: #selector(touchDragInside), for: .touchDragInside)
        return aInstance
    }

    var dragCallBack = { (pointView: PointView) -> Void in }

    @objc func touchDragInside(pointView: PointView, withEvent event: UIEvent) {

        for touch in event.allTouches! {

            pointView.center = (touch).location(in: superview)
            dragCallBack(self)
            return
        }
    }
}
