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
}
