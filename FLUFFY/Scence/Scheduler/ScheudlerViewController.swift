//
//  ScheudlerViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import UIKit
import PanModal
import FSCalendar

class ScheudlerViewController: BaseViewController {
    
    private let apiService = NetworkService()
    
    private var selectedDate : String = Date().toString()
    
    private var events : [Date] = []
    
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
        button.addTarget(self, action: #selector(prevCurrentPage), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.addTarget(self, action: #selector(nextCurrentPage), for: .touchUpInside)
        return button
    }()
    
    private var currentPage: Date?
    private lazy var today: Date = {
        return Date()
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "yyyy년 MM월"
        return df
    }()
    
    @objc private func nextCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.weekOfMonth = 1
        
        self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendar.setCurrentPage(self.currentPage!, animated: true)
    }
    
    @objc private func prevCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.weekOfMonth = -1
        
        self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendar.setCurrentPage(self.currentPage!, animated: true)
    }
    
    
    private let tableView : UITableView = {
        let view = UITableView()
        return view
    }()
    
    private lazy var addButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = UIColor(hex: "89BFFF")
        button.setPreferredSymbolConfiguration(.init(pointSize: 68, weight: .light, scale: .default), forImageIn: .normal)
        button.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        return button
    }()
    
    //    fileprivate weak var calendar: FSCalendar!
    private let calendar : FSCalendar = {
        let calendar = FSCalendar(frame: .zero)
        calendar.weekdayHeight = 15
        calendar.headerHeight = 0
        calendar.appearance.eventDefaultColor = UIColor(hex: "C6C6C6")
        calendar.appearance.eventSelectionColor = UIColor(hex: "C6C6C6")
        calendar.appearance.headerTitleFont = UIFont.pretendard(.bold, size: 15)
        calendar.appearance.weekdayFont = UIFont.pretendard(.bold, size: 11)
        calendar.appearance.headerTitleColor = UIColor(hex: "2D2D2D")
        calendar.appearance.weekdayTextColor = UIColor(hex: "ADADAD")
        calendar.appearance.titleTodayColor = UIColor(hex: "0600FE")
        calendar.appearance.todayColor = .clear
        calendar.appearance.selectionColor = .clear
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "cell")
        calendar.appearance.titleSelectionColor = UIColor(hex: "0600FE")
        calendar.locale = Locale(identifier: "us_US")
        calendar.scope = .week
        calendar.firstWeekday = 2
        calendar.appearance.titleFont = UIFont.pretendard(.bold, size: 15)
        
        return calendar
    }()
    
    
    @objc private func addButtonClicked(_ sender: UIButton) {
        let vc = ModalViewController()
        vc.selectedDate = self.selectedDate
        self.presentPanModal(vc)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        print("today - \(selectedDate)")
        self.configure()
        setEvents()
    }
    
    private func configure() {
        self.configureStatus()
        self.configureTitleLabel()
        self.configureFSCalendar()
        self.configureNextButton()
        self.configurePreviousButton()
        self.configureAddButton()
        self.configureTableView()
        
    }
    
    private func setEvents() {
        let dfMatter = DateFormatter()
        dfMatter.locale = Locale(identifier: "ko_KR")
        dfMatter.dateFormat = "yyyy-MM-dd"
        
        let myFirstEvent = dfMatter.date(from: "2023-06-07")
        
        events = [myFirstEvent!]
    }
    
    private func configureFSCalendar() {
        self.view.addSubview(calendar)
        calendar.delegate = self
        calendar.dataSource = self
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 17),
            calendar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            calendar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            calendar.heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
    private func configureStatus() {
        self.view.addSubview(self.statusLabel)
        self.view.addSubview(self.statusIamge)
        self.statusLabel.translatesAutoresizingMaskIntoConstraints = false
        self.statusIamge.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.statusLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 14),
            self.statusLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.statusIamge.centerYAnchor.constraint(equalTo: self.statusLabel.centerYAnchor),
            self.statusIamge.heightAnchor.constraint(equalToConstant: 18),
            self.statusIamge.widthAnchor.constraint(equalToConstant: 54),
            self.statusIamge.leadingAnchor.constraint(equalTo: self.statusLabel.trailingAnchor, constant: 5)
        ])
    }
    
    private func configureTitleLabel() {
        self.view.addSubview(self.titleLabel)
        self.titleLabel.text = self.dateFormatter.string(from: Date())
        self.titleLabel.font = UIFont.pretendard(.bold, size: 15)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.statusLabel.bottomAnchor, constant: 14),
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
    
    
    private func configureTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.rowHeight = 64
        tableView.separatorStyle = .none
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.calendar.bottomAnchor, constant: 26),
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



extension ScheudlerViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as? TaskTableViewCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 통신 - DB에서 데이터 삭제 메서드
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 수정 모달 팝업 - 통신해서 해당 날짜에 기존 데이터 없으면 실행 x
        let vc = EditModalViewController()
        vc.selectedDate = selectedDate
        present(vc, animated: true)
    }
}


extension ScheudlerViewController: UISheetPresentationControllerDelegate {
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        //크기 변경 됐을 경우
        print(sheetPresentationController.selectedDetentIdentifier == .large ? "large" : "medium")
    }
}

extension ScheudlerViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.titleLabel.text = self.dateFormatter.string(from: calendar.currentPage)
        print("current: \(calendar.currentPage)")
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        calendar.appearance.titleTodayColor = UIColor(hex: "2D2D2D")
        print("date: \(date)")
        selectedDate = date.toString()
        print("selectedDate = \(selectedDate)")
        
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.events.contains(date) {
            return 3
//            return events.count
        }
        else {
            return 0
        }
    }
    
    
}

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: self)
    }
}
