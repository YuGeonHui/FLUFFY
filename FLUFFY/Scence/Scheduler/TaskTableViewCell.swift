//
//  TaskTableViewCell.swift
//  FLUFFY
//
//  Created by 김강현 on 2023/05/30.
//

import UIKit
import PanModal

class TaskTableViewCell: UITableViewCell {
    
    private let taskView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 11
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.cornerRadius = 16
        return view
    }()
    
    let taskLabel : UILabel = {
        let label = UILabel()
        label.text = "아직 일정이 없어요."
        label.font = UIFont.pretendard(.semiBold, size: 18)
        label.textColor = UIColor(hex: "CECECE")
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(hex: "8D8D8D")
        label.font = UIFont.pretendard(.medium, size: 12)
        return label
    }()
    
    let statusIcon : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "0")
        return image
    }()
    
    private let line : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "line")
        return image
    }()
    
    static let identifier = "TaskTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addContentView() {
        contentView.addSubview(statusIcon)
        contentView.addSubview(taskView)
        contentView.addSubview(taskLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(line)
        contentView.backgroundColor = UIColor(hex: "F9F9F9")
        
        statusIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusIcon.topAnchor.constraint(equalTo: contentView.topAnchor),
            statusIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            statusIcon.widthAnchor.constraint(equalToConstant: 18),
            statusIcon.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        
        taskView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taskView.topAnchor.constraint(equalTo: contentView.topAnchor),
            taskView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            taskView.leadingAnchor.constraint(equalTo: statusIcon.trailingAnchor, constant: 20),
            taskView.heightAnchor.constraint(equalToConstant: 51),
            taskView.widthAnchor.constraint(equalToConstant: 220)
        ])
        
        
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taskLabel.centerYAnchor.constraint(equalTo: taskView.centerYAnchor),
            taskLabel.leadingAnchor.constraint(equalTo: taskView.leadingAnchor, constant: 17)
        ])
        
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: self.taskView.centerYAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: self.taskView.trailingAnchor, constant: -12)
        ])
        
        
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line.centerXAnchor.constraint(equalTo: statusIcon.centerXAnchor),
            line.topAnchor.constraint(equalTo: statusIcon.bottomAnchor, constant: 9),
            line.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            line.widthAnchor.constraint(equalToConstant: 1)
        ])
        
        
    }
    
}
