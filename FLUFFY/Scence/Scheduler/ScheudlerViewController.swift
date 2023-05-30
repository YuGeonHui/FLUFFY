//
//  ScheudlerViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import UIKit
import PanModal

class ScheudlerViewController: BaseViewController {
    
    private let statusLabel : UILabel = {
        let label = UILabel()
        label.text = "(유저 닉네임)의 현재 상태"
        label.font = UIFont.pretendard(.medium, size: 15)
        label.textColor = UIColor(red: 0.321, green: 0.321, blue: 0.321, alpha: 1)
        return label
    }()
    
    private let statusIamge : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "WarningStatus")
        return image
    }()
    
    private let titleLabel : UILabel = {
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
    
    private let collectionView : UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    private let tableView : UITableView = {
        let view = UITableView()
        return view
    }()
    
    private lazy var addButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = UIColor(hex: "D9D9D9")
        button.setPreferredSymbolConfiguration(.init(pointSize: 68, weight: .regular, scale: .default), forImageIn: .normal)
        button.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - 캘린더 관련 변수
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
    
    @objc private func addButtonClicked(_ sender: UIButton) {
        let vc = ModalViewController()
        self.presentPanModal(vc)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.configure()
    }
    
    private func configure() {
        self.configureStatus()
        self.configureTitleLabel()
        self.configureNextButton()
        self.configurePreviousButton()
        self.configureCollectionView()
        self.configureAddButton()
        self.configureCalendar()
        self.configureTableView()
        
    }
    
    private func configureStatus() {
        self.view.addSubview(self.statusLabel)
        self.view.addSubview(self.statusIamge)
        self.statusLabel.translatesAutoresizingMaskIntoConstraints = false
        self.statusIamge.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.statusLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5),
            self.statusLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.statusIamge.centerYAnchor.constraint(equalTo: self.statusLabel.centerYAnchor),
            self.statusIamge.heightAnchor.constraint(equalToConstant: 18),
            self.statusIamge.widthAnchor.constraint(equalToConstant: 54),
            self.statusIamge.leadingAnchor.constraint(equalTo: self.statusLabel.trailingAnchor, constant: 5)
        ])
    }
    
    private func configureTitleLabel() {
        self.view.addSubview(self.titleLabel)
        self.titleLabel.text = "2000년 01월"
        self.titleLabel.font = UIFont.pretendard(.bold, size: 15)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.statusLabel.bottomAnchor, constant: 7),
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
            self.collectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func configureTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 26),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureAddButton() {
        self.tableView.addSubview(self.addButton)
        self.addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.addButton.heightAnchor.constraint(equalToConstant: 68),
            self.addButton.widthAnchor.constraint(equalToConstant: 68),
            self.addButton.bottomAnchor.constraint(equalTo: self.tableView.frameLayoutGuide.bottomAnchor, constant: -33),
            self.addButton.trailingAnchor.constraint(equalTo: self.tableView.frameLayoutGuide.trailingAnchor, constant: -20)
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

extension ScheudlerViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as? TaskTableViewCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        return cell
    }
}

extension ScheudlerViewController {
    
    private func configureCalendar() {
        let components = self.calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        self.calendarDate = self.calendar.date(from: components) ?? Date()
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
        self.collectionView.reloadData()
    }
    
    private func updateMinus() {
        self.updateTitle()
        self.weekDays.removeAll()
        let firstWeekdayComponents = calendar.dateComponents([.day], from: self.calendarDate)
        guard let weekday = firstWeekdayComponents.day else {return}
        
        firstDay = weekday - 6
        
        if weekDaysLast < 14 {
            if let previousMonth = calendar.date(byAdding: .month, value: -1, to: self.calendarDate) {
                if let lastDayOfPreviousMonth = calendar.range(of: .day, in: .month, for: previousMonth)? .count {
                    endDateNum = lastDayOfPreviousMonth
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
        self.calendarDate = self.calendar.date(byAdding: .day, value: -7, to: self.calendarDate) ?? Date()
        endDateNum = self.endDate()
        self.updateMinus()
    }
    
    private func plusWeek() {
        countDay = 0
        endDateNum = self.endDate()
        weekDaysLast = Int(weekDays.last!)!
        self.calendarDate = self.calendar.date(byAdding: .day, value: 7, to: self.calendarDate) ?? Date()
        self.updatePlus()
    }
}

extension ScheudlerViewController: UISheetPresentationControllerDelegate {
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        //크기 변경 됐을 경우
        print(sheetPresentationController.selectedDetentIdentifier == .large ? "large" : "medium")
    }
}




