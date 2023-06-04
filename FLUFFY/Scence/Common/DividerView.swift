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
        self.setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = UIColor(hex: "b1b1b1")
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupAutoLayout() {
        
        guard let superview = superview else { return }
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 20),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -20),
            heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
