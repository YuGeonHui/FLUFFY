//
//  OnBoardingContenViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/04.
//

import UIKit
import SwiftRichString

final class OnBoardingContenViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let descLabel = UILabel()
    private let guideImgeView = UIImageView()
    private lazy var stackView = UIStackView(arrangedSubviews: [titleLabel, descLabel])
    
    private(set) var titleText: String
    private(set) var descText: String
    private(set) var image: UIImage?
    
    private enum Metric {
        static let spacing: CGFloat = 18
    }
    
    private enum Styles {
        
        static let title: Style = Style {
            $0.font = UIFont.pretendard(.bold, size: 20)
            $0.color = UIColor(hex: "2d2d2d")
            $0.alignment = .center
        }
        
        static let desc: Style = Style {
            $0.font = UIFont.pretendard(.regular, size: 15)
            $0.color = UIColor(hex: "6a6a6a")
            $0.alignment = .center
            $0.minimumLineHeight = 23
            $0.maximumLineHeight = 23
        }
    }
    
    init(titleText: String, descText: String, image: UIImage?) {
        
        self.titleText = titleText
        self.descText = descText
        self.image = image
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: "f9f9f9")
        
        self.setupViews()
        self.setupAutoLayout()
    }
    
    private func setupViews() {
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.guideImgeView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(stackView)
        self.view.addSubview(guideImgeView)
        
        self.stackView.axis = .vertical
        self.stackView.alignment = .center
        self.stackView.distribution = .fill
        self.stackView.spacing = Metric.spacing
        
        self.titleLabel.attributedText = self.titleText.set(style: Styles.title)
        self.titleLabel.numberOfLines = 2
        
        self.descLabel.attributedText = self.descText.set(style: Styles.desc)
        self.descLabel.numberOfLines = 2
        
        self.guideImgeView.image = self.image
        self.guideImgeView.contentMode = .scaleAspectFit
    }
    
    private func setupAutoLayout() {
        
        NSLayoutConstraint.activate([
        
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 38),
            
//            guideImgeView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 100),
            guideImgeView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45),
            guideImgeView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45),
            guideImgeView.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 70)
        ])
    }
}
