//
//  CalendarCollectionViewCell.swift
//  FLUFFY
//
//  Created by 김강현 on 2023/05/29.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CalendarCollectionViewCell"
    
    let dayLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(hex: "2D2D2D")
        label.font = UIFont.pretendard(.bold, size: 15)
        return label
    }()
    
    let weekTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "월"
        label.textColor = UIColor(hex: "ADADAD")
        label.font = UIFont.pretendard(.bold, size: 11)
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                dayLabel.textColor = UIColor(hex: "0600FE")
                weekTitleLabel.textColor = UIColor(hex: "0600FE")
            }
            else {
                dayLabel.textColor = UIColor(hex: "2D2D2D")
                weekTitleLabel.textColor = UIColor(hex: "ADADAD")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    func update(day: String, weekTitle: String) {
        self.dayLabel.text = day
        self.weekTitleLabel.text = weekTitle
    }
    
    private func configure() {
        self.addSubview(self.dayLabel)
        self.addSubview(self.weekTitleLabel)
        
        self.dayLabel.translatesAutoresizingMaskIntoConstraints = false
        self.weekTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.weekTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.weekTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.dayLabel.topAnchor.constraint(equalTo: self.weekTitleLabel.bottomAnchor, constant: 5),
            self.dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
    }
    
}
