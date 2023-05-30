//
//  ScheudlerViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import UIKit

class ScheudlerViewController: BaseViewController {
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    private lazy var previousButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(didPreviousButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.addTarget(self, action: #selector(didNextButtonClicked), for: .touchUpInside)
        return button
    }()
    
    let collectionView : UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    private var calendarDate = Date()
    private var weekDays = [String]()
    private var weekTitle : [String] = ["월", "화", "수", "목", "금", "토", "일"]
    private var firstDay = 0
    private var countDay = 0
    private var endDateNum = 0
    private var weekDaysLast = 0
    
    @objc private func didPreviousButtonClicked(_ sender: UIButton) {
        self.minusWeek()
    }
    
    @objc private func didNextButtonClicked(_ sender: UIButton) {
        self.plusWeek()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.configure()
    }
    
    private func configure() {
        self.configureTitleLabel()
        self.configureNextButton()
        self.configurePreviousButton()
        self.configureCollectionView()
        self.configureCalendar()
        
    }
    
    private func configureTitleLabel() {
        self.view.addSubview(self.titleLabel)
        self.titleLabel.text = "2000년 01월"
        self.titleLabel.font = UIFont.pretendard(.bold, size: 15)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    private func configureNextButton() {
        self.view.addSubview(self.nextButton)
        self.nextButton.tintColor = .black
        self.nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.nextButton.widthAnchor.constraint(equalToConstant: 24),
            self.nextButton.heightAnchor.constraint(equalToConstant: 24),
            self.nextButton.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant: -20),
            self.nextButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor)
        ])
    }
    
    private func configurePreviousButton() {
        self.view.addSubview(self.previousButton)
        self.previousButton.tintColor = .black
        self.previousButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.previousButton.widthAnchor.constraint(equalToConstant: 24),
            self.previousButton.heightAnchor.constraint(equalToConstant: 24),
            self.previousButton.trailingAnchor.constraint(equalTo: self.nextButton.leadingAnchor, constant: -8),
            self.previousButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor)
        ])
    }
    
    private func configureCollectionView() {
        self.view.addSubview(self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.heightAnchor.constraint(equalTo: self.collectionView.widthAnchor, multiplier: 1.5)
        ])
        
    }
}

extension ScheudlerViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else {return UICollectionViewCell()}
        cell.update(day: self.weekDays[indexPath.item], weekTitle: self.weekTitle[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width / 7
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}

extension ScheudlerViewController {
    
    private func configureCalendar() {
        let components = self.calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        self.calendarDate = self.calendar.date(from: components) ?? Date()
        print("calendarDate:\(self.calendarDate)")
        self.dateFormatter.dateFormat = "yyyy년 MM월"
        self.updateCalendar()
    }
    
    private func endDate() -> Int {
        return self.calendar.range(of: .day, in: .month, for: self.calendarDate)? .count ?? Int()
    }
    
    
    private func updateTitle() {
        let date = self.dateFormatter.string(from: self.calendarDate)
        self.titleLabel.text = date
    }
    
    private func updatePlus() {
        self.updateTitle()
        self.weekDays.removeAll()
        let firstWeekdayComponents = calendar.dateComponents([.day], from: self.calendarDate)
        guard let weekday = firstWeekdayComponents.day else {return}
        
        firstDay = weekday - 6
        
        for day in 0..<7 {
            if firstDay < 1 && weekDaysLast != endDateNum {
                self.weekDays.append(String(weekDaysLast+1))
                weekDaysLast += 1
                firstDay += 1
                countDay = weekDays.count
            } else {
                weekDays.append(String(firstDay+day-countDay))
            }
        }
        
        print("weekDays: \(weekDays)")
        self.collectionView.reloadData()
    }
    
    private func updateMinus() {
        self.updateTitle()
        self.weekDays.removeAll()
        let firstWeekdayComponents = calendar.dateComponents([.day], from: self.calendarDate)
        guard let weekday = firstWeekdayComponents.day else {return}
        
        firstDay = weekday - 6
        print("weekday: \(weekday)")
        print("firstday: \(firstDay)")
        
        if weekDaysLast < 14 {
            if let previousMonth = calendar.date(byAdding: .month, value: -1, to: self.calendarDate) {
                if let lastDayOfPreviousMonth = calendar.range(of: .day, in: .month, for: previousMonth)? .count {
                    endDateNum = lastDayOfPreviousMonth
                    print("minus - endDateNum: \(endDateNum)")
                }
            }
        }
        
        for day in 0..<7 {
            if firstDay < 1 {
                self.weekDays.append(String(endDateNum + firstDay))
                firstDay += 1
                countDay = weekDays.count
            } else {
                weekDays.append(String(firstDay+day-countDay))
            }
        }
        self.collectionView.reloadData()
    }
    
    private func updateCalendar() {
        self.updateTitle()
        self.updatePlus()
    }
    
    private func minusWeek() {
        countDay = 0
        weekDaysLast = Int(weekDays.last!)!
        print("weekDaysLast: \(weekDaysLast)")
        self.calendarDate = self.calendar.date(byAdding: .day, value: -7, to: self.calendarDate) ?? Date()
        endDateNum = self.endDate()
        print("endDate: \(endDateNum)")
        print("minusWeek : \(self.calendarDate)")
        self.updateMinus()
    }
    
    private func plusWeek() {
        countDay = 0
        endDateNum = self.endDate()
        weekDaysLast = Int(weekDays.last!)!
        print("endDate: \(endDateNum)")
        print("weekDaysLast: \(weekDaysLast)")
        self.calendarDate = self.calendar.date(byAdding: .day, value: 7, to: self.calendarDate) ?? Date()
        print("plusWeek : \(self.calendarDate)")
        self.updatePlus()
    }
}

