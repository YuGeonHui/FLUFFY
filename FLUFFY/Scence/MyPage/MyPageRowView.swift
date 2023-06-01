//
//  MyPageRowView.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/01.
//

import UIKit
import SwiftRichString

final class MyPageRowView: UIView {
    
    private(set) var title: String
    
    private enum Metric {
        
        static let arrowSize: CGSize = CGSize(width: 24, height: 24)
        static let height: CGFloat = 35
    }
    
    private enum Styles {
        
        static var title: Style = Style {
            $0.font = UIFont.pretendard(.semiBold, size: 18)
            $0.color = UIColor(hex: "2d2d2d")
        }
    }
    
    init(frame: CGRect, title: String) {
        self.title = title
        super.init(frame: frame)
        
        self.setupViews()
        self.setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init(frame: .zero, title: title)
    }
    
    private let titleLabel = UILabel()
    private let arrowImageView = UIImageView()
    private lazy var stackView = UIStackView(arrangedSubviews: [titleLabel, arrowImageView])
    
    private func setupViews() {
        
        self.addSubview(stackView)
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .horizontal
        
        self.arrowImageView.image = UIImage(named: "Polygon 1")
        self.arrowImageView.contentMode = .scaleAspectFit
        
        self.titleLabel.attributedText = self.title.set(style: Styles.title)
    }
    
    private func setupAutoLayout() {
        
        NSLayoutConstraint.activate([
            self.arrowImageView.widthAnchor.constraint(equalToConstant: Metric.arrowSize.width),
            self.arrowImageView.heightAnchor.constraint(equalToConstant: Metric.arrowSize.height)
        ])
    }
}
