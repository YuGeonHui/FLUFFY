//
//  PaddingLabel.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/04.
//

import UIKit

class PaddingLabel: UILabel {
    
    var padding: UIEdgeInsets = .zero {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
        
        self.layer.cornerRadius = 15.5
        self.clipsToBounds = true
        self.textAlignment = .center
        self.textColor = UIColor(hex: "ffffff")
    }

    override var intrinsicContentSize: CGSize {
        
        let size = super.intrinsicContentSize
        let width = size.width + padding.left + padding.right
        let height = size.height + padding.top + padding.bottom
        
        return CGSize(width: width, height: height)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        
        let width = size.width - padding.left - padding.right
        let height = size.height - padding.top - padding.bottom
        let targetSize = CGSize(width: width, height: height)
        let textSize = super.sizeThatFits(targetSize)
        
        return CGSize(width: textSize.width + padding.left + padding.right, height: textSize.height + padding.top + padding.bottom)
    }
}
