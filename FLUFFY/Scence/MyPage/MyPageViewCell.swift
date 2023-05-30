//
//  MyPageViewCell.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/29.
//

import UIKit
import Then

final class MyPageViewCell: UITableViewCell {
    
    static let identifier = "MyPageViewCell"
    
    private let titleLabel = UILabel()
    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "Expand_right")
    }
    
    private lazy var stackView = UIStackView(arrangedSubviews: [titleLabel, iconImageView]).then {
        $0.distribution = .fill
        $0.alignment = .fill
        $0.axis = .horizontal
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupViews()
    }
    
    
    private func setupViews() {
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func configure(with title: String) {
        
        
    }
}
