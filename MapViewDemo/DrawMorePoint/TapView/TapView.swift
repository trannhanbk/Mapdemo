//
//  TapView.swift
//  MapViewDemo
//
//  Created by Nhan Tran D on 6/20/19.
//  Copyright © 2019 MBA0145. All rights reserved.
//

import UIKit

protocol TapViewDelegate: class {
    func view(view: TapView, action: TapView.Action)
}

class TapView: UIView {

    enum Action {
        case tapMoved
    }

    weak var delegate: TapViewDelegate?

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.view(view: self, action: .tapMoved)
    }
}
