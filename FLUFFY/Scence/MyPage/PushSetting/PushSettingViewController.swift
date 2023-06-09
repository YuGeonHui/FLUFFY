//
//  PushSettingViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/30.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftRichString

final class PushSettingViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private enum Metric {
        
        static let spacing: CGFloat = 20
        
        static let timePickerHeight: CGFloat = 54
        static let timePickerInset: CGFloat = 18
        
        static let iconWidth: CGFloat = 15
        
        static let titleSpacing: CGFloat = 16
        static let titleAfter: CGFloat = 60
        static let titleBefore: CGFloat = 12
        
        static let btnHeight: CGFloat = 53
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
            $0.minimumLineHeight = 26
            $0.maximumLineHeight = 26
            $0.alignment = .center
        }
        
        static let time: Style = Style {
            $0.font = UIFont.pretendard(.medium, size: 15)
            $0.color = UIColor(hex: "454545")
        }
    }
    
    private let titleLabel = UILabel().then {
        $0.attributedText = "알림받을 시간을 설정해주세요.".set(style: Styles.title)
    }
    
    private let descLabel = UILabel().then {
        $0.attributedText = "번아웃을 예방하는 습관을 만들 수 있도록\n원하는 시간에 알림을 보내드릴게요!".set(style: Styles.desc)
        $0.numberOfLines = 0
    }
    
    private lazy var titleStackView = UIStackView(arrangedSubviews: [titleLabel, descLabel]).then {
        $0.axis = .vertical
        $0.spacing = Metric.titleSpacing
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alignment = .center
    }
        
    private let timePickerView = UITextField().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let datePicker = UIDatePicker().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let saveButton = CommonButtonView(background: UIColor(hex: "000000"), title: "저장하기").then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupViews()
        createDatePicker()
        bindView()
    }
    
    private func createToolBar() -> UIToolbar {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonTapped))
        toolbar.setItems([doneBtn], animated: true)
        
        return toolbar
    }
    
    func createDatePicker() {
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        datePicker.minuteInterval = 15
        
        timePickerView.inputView = datePicker
        timePickerView.inputAccessoryView = createToolBar()

        timePickerView.borderStyle = .line
        timePickerView.layer.borderColor = UIColor(hex: "cccccc").cgColor
        timePickerView.layer.borderWidth = 1.0
        timePickerView.layer.cornerRadius = 5
        timePickerView.clipsToBounds = true
        timePickerView.tintColor = UIColor.clear
        timePickerView.font = UIFont.pretendard(.medium, size: 15)
        timePickerView.textColor = UIColor(hex: "454545")
        timePickerView.text = "오후 10:00"
        
        let rightInsetView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: Metric.timePickerHeight))
        
        let imageView = UIImageView(image: UIImage(named: "Polygon 1"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 22, width: 15, height: 10)
        rightInsetView.addSubview(imageView)
        
        timePickerView.rightView = rightInsetView
        timePickerView.rightViewMode = .always
        
        let leftInsetView = UIView(frame: CGRect(x: 0, y: 0, width: Metric.timePickerInset, height: Metric.timePickerHeight))
        timePickerView.leftView = leftInsetView
        timePickerView.leftViewMode = .always
    }
    
    @objc func doneButtonTapped() {
        
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "a h:mm"
        
        let date = dateFormmater.string(from: datePicker.date)
        timePickerView.text = date
        
        self.view.endEditing(true)
    }
    
    private func setupViews() {
        
        self.view.addSubview(titleStackView)
        self.view.addSubview(timePickerView)
        self.view.addSubview(saveButton)
        
        titleStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Metric.titleBefore).isActive = true
        titleStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Metric.spacing).isActive = true
        titleStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Metric.spacing).isActive = true
        
        timePickerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Metric.spacing).isActive = true
        timePickerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Metric.spacing).isActive = true
        timePickerView.topAnchor.constraint(equalTo: self.titleStackView.bottomAnchor, constant: Metric.titleAfter).isActive = true
        timePickerView.heightAnchor.constraint(equalToConstant: Metric.timePickerHeight).isActive = true
        
        NSLayoutConstraint.activate([
            saveButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            saveButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: Metric.btnHeight)
        ])
    }
    
    private func bindView() {
        
        self.saveButton.buttonTapped
            .withUnretained(self)
            .bind(onNext: { $0.0.navigationController?.popViewController(animated: true) })
            .disposed(by: self.disposeBag)
    }
}
