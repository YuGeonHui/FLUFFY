//
//  CustomSlider.swift
//  FLUFFY
//
//  Created by 김강현 on 2023/05/31.
//

import UIKit

class CustomSlider: UISlider {
    
    var trackLineHeight: CGFloat = 10
    
    override func trackRect(forBounds bound: CGRect) -> CGRect {
        return CGRect(origin: bound.origin, size: CGSize(width: bound.width, height: trackLineHeight))
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var bounds: CGRect = self.bounds
        bounds = bounds.insetBy(dx: -10, dy: -15)
        return bounds.contains(point)
    }
}
