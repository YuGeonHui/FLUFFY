//
//  PaddingLabel.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/04.
//

import UIKit

class PaddingLabel: UILabel {
    
    var padding: UIEdgeInsets = UIEdgeInsets(top: 9, left: 12, bottom: 9, right: 12) {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
        
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        
        self.font = UIFont.candyBean(.normal, size: 15)
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
