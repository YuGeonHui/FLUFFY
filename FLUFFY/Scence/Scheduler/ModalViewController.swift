//
//  ModalViewController.swift
//  FLUFFY
//
//  Created by 김강현 on 2023/05/30.
//

import UIKit
import PanModal

class ModalViewController: UIViewController{
    
    var selectedDate : String = ""
    
    private var pickerDate : Date?
    
    private let stressWord : [String] = [
        "스트레스 완전 회복~! 100%",
        "이게 휴식이지~! 회복 80%",
        "마음의 안정 :) 회복 60%",
        "조금 아쉬운 휴식, 회복 40%",
        "쉬긴 쉰걸까..? 회복 20%",
        "없음",
        "이정도야 뭐 :) 스트레스 20%",
        "일은 일이구나.. 스트레스 40%",
        "나 조금 힘들지도..? 스트레스 60%",
        "지친다 지쳐.. 스트레스 80%",
        "너무 힘든 하루.. 스트레스 100%"
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
        print("modal select - \(selectedDate)")
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
    
    
    private lazy var datePicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.minuteInterval = 30
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ko_KR")
        return picker
    }()

    
    private let dateTextField : UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 15.5
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor(hex: "C5C5C5").cgColor
        textField.backgroundColor = UIColor(hex: "F5F5F5")
        textField.clipsToBounds = true
        textField.tintColor = .clear
        return textField
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.configure()
    }
    
    private func createToolBar() -> UIToolbar {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonTapped))
        toolbar.setItems([doneBtn], animated: true)
        
        return toolbar
    }
    
    @objc func doneButtonTapped() {
        
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "a h:mm"
        dateFormmater.locale = Locale(identifier: "ko_KR")
        
        let date = dateFormmater.string(from: datePicker.date)
        dateTextField.text = date
        dateTextField.font = UIFont.pretendard(.medium, size: 15)
        
        self.view.endEditing(true)
    }
    
    private func configure() {
        self.configureTaskTextField()
        self.configureDateTextField()
        self.createDatePicker()
        self.configureLineView()
        self.configureCheckButton()
        self.configureChooseLabel()
        self.configureStressLabel()
        self.configureSlider()
        self.configureLabel()
    }
    
    
    private func configureTaskTextField() {
        self.view.addSubview(taskTextField)
        self.taskTextField.delegate = self
        self.taskTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            taskTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 85),
            taskTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            taskTextField.heightAnchor.constraint(equalToConstant: 36),
            taskTextField.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureDateTextField() {
        self.view.addSubview(dateTextField)
        
        self.dateTextField.delegate = self
        self.dateTextField.translatesAutoresizingMaskIntoConstraints = false
        self.dateTextField.inputView = self.datePicker
        
        NSLayoutConstraint.activate([
            dateTextField.centerYAnchor.constraint(equalTo: self.taskTextField.centerYAnchor),
            dateTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25),
            dateTextField.heightAnchor.constraint(equalToConstant: 27),
            dateTextField.widthAnchor.constraint(equalToConstant: 94)
        ])
    }
    
    private func createDatePicker() {
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = createToolBar()
        
        let leftInsetView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        dateTextField.leftView = leftInsetView
        dateTextField.leftViewMode = .always
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
            lineView.topAnchor.constraint(equalTo: self.taskTextField.bottomAnchor, constant: 5),
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


