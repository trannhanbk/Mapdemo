//
//  MoveViewController.swift
//  MapViewDemo
//
//  Created by Nhan Tran D on 6/18/19.
//  Copyright © 2019 MBA0145. All rights reserved.
//

import UIKit

class MoveViewController: UIViewController {

    @IBOutlet private weak var viewDrag: UIView!

    var panGesture  = UIPanGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_:)))
        viewDrag.isUserInteractionEnabled = true
        viewDrag.addGestureRecognizer(panGesture)
    }

    @objc func draggedView(_ sender: UIPanGestureRecognizer) {
        self.view.bringSubviewToFront(viewDrag)
        let translation = sender.translation(in: self.view)
        viewDrag.center = CGPoint(x: viewDrag.center.x + translation.x, y: viewDrag.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        print(translation)
        print(viewDrag.frame)
    }
}
