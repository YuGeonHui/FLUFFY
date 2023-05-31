//
//  ModalViewController.swift
//  FLUFFY
//
//  Created by 김강현 on 2023/05/30.
//

import UIKit
import PanModal

class ModalViewController: UIViewController{
    
    private let stressWord : [String] = [
        "-5", "-4", "-3", "-2", "-1", "0", "1", "2", "3", "4", "5"
    ]
    
    private lazy var checkButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = UIColor(hex: "C0C0C0")
        button.setPreferredSymbolConfiguration(.init(pointSize: 24, weight: .bold, scale: .default), forImageIn: .normal)
        button.addTarget(self, action: #selector(buttonIsClikced), for: .touchUpInside)
        return button
    }()
    
    @objc private func buttonIsClikced() {
        self.dismiss(animated: true)
    }
    
    private let taskTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "일정 입력"
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: [.foregroundColor : UIColor(hex: "DCDCDC"), .font : UIFont.pretendard(.bold, size: 20)])
        textField.borderStyle = .none
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .unlessEditing
        return textField
    }()
    
    private let datePicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .compact
        picker.locale = Locale(identifier: "ko_KR")
        picker.datePickerMode = .time
        picker.minuteInterval = 30
        return picker
    }()
    
    private let lineView : UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(hex: "B6B6B6").cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    private let chooseLabel : UILabel = {
        let label = UILabel()
        label.text = "스트레스 지수"
        label.font = UIFont.pretendard(.semiBold, size: 18)
        label.textColor = UIColor(hex: "2D2D2D")
        return label
    }()
    private let stressLabel : UILabel = {
        let label = UILabel()
        label.text = "없음"
        label.font = UIFont.pretendard(.regular, size: 15)
        label.textColor = UIColor(hex: "5F5F5F")
        return label
    }()
    
    private lazy var slider : UISlider = {
        let slider = CustomSlider()
        slider.minimumValue = -5
        slider.maximumValue = 5
        slider.trackLineHeight = 5
        slider.setMinimumTrackImage(UIImage(named: "modalLine"), for: .normal)
        slider.setMaximumTrackImage(UIImage(named: "modalLine"), for: .normal)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        return slider
    }()
    
    private let leftLabel : UILabel = {
        let label = UILabel()
        label.text = "해소"
        label.font = UIFont.pretendard(.medium, size: 12)
        label.textColor = UIColor(hex: "ADADAD")
        return label
    }()
    
    private let rightLabel : UILabel = {
        let label = UILabel()
        label.text = "누적"
        label.font = UIFont.pretendard(.medium, size: 12)
        label.textColor = UIColor(hex: "ADADAD")
        return label
    }()
    
    @objc private func sliderValueChanged(_ slider: UISlider) {
        let value = Int(slider.value) + 5
        stressLabel.text = stressWord[value]
        print("value: \(Int(slider.value))")
    }
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 7
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.configure()
    }
    
    private func configure() {
        self.configureStackView()
        self.configureLineView()
        self.configureCheckButton()
        self.configureChooseLabel()
        self.configureStressLabel()
        self.configureSlider()
        self.configureLabel()
    }
    
    private func configureStackView() {
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(taskTextField)
        stackView.addArrangedSubview(datePicker)
        
        self.taskTextField.delegate = self
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 85),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25),
            datePicker.widthAnchor.constraint(equalToConstant: 94),
            stackView.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    private func configureChooseLabel() {
        self.view.addSubview(self.chooseLabel)
        self.chooseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chooseLabel.topAnchor.constraint(equalTo: self.lineView.bottomAnchor, constant: 25),
            chooseLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25)
        ])
    }
    
    private func configureStressLabel() {
        self.view.addSubview(self.stressLabel)
        self.stressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stressLabel.topAnchor.constraint(equalTo: self.chooseLabel.bottomAnchor, constant: 13),
            stressLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    private func configureCheckButton() {
        self.view.addSubview(self.checkButton)
        self.checkButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkButton.widthAnchor.constraint(equalToConstant: 28),
            checkButton.heightAnchor.constraint(equalToConstant: 28),
            checkButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 24),
            checkButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25)
        ])
    }
    
    
    private func configureLineView() {
        self.view.addSubview(self.lineView)
        self.lineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: 0.5),
            lineView.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 5),
            lineView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            lineView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25)
        ])
    }
    
    private func configureSlider() {
        self.view.addSubview(self.slider)
        self.slider.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            slider.heightAnchor.constraint(equalToConstant: 5),
            slider.topAnchor.constraint(equalTo: self.stressLabel.bottomAnchor, constant: 30),
            slider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 28),
            slider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -28)
        ])
    }
    
    private func configureLabel() {
        self.view.addSubview(self.leftLabel)
        self.view.addSubview(self.rightLabel)
        self.leftLabel.translatesAutoresizingMaskIntoConstraints = false
        self.rightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftLabel.topAnchor.constraint(equalTo: self.slider.bottomAnchor, constant: 15),
            leftLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            rightLabel.topAnchor.constraint(equalTo: self.slider.bottomAnchor, constant: 15),
            rightLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25)
        ])
    }
    
}

extension ModalViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(string)
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard textField.text!.count < 20 else { return false }
        return true
    }
    
}

extension ModalViewController: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var topOffset : CGFloat {
        return 160
    }
    
    var cornerRadius: CGFloat {
        return 12
    }
}

