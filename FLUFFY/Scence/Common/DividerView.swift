//
//  DividerView.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/03.
//

import UIKit

final class DividerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        self.backgroundColor = UIColor(hex: "b1b1b1")
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
