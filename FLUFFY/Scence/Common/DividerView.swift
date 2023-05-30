//
//  DividerView.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/30.
//

import UIKit

class DividerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        self.backgroundColor = UIColor(hex: "b1b1b1")
//        self.widthAnchor.con
    }
}
