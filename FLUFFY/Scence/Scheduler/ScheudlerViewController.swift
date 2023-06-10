//
//  ScheudlerViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import UIKit
import PanModal
import FSCalendar
import Alamofire



class ScheudlerViewController: BaseViewController {
    
    private let apiService = NetworkService()
    
    private var selectedDate : String = Date().toString()
    
    private var grayEvents : [Date] = []
    private var redEvents : [Date] = []
    private var blueEvents : [Date] = []
    
    private var todayDate : Date?
    
    private var userName = "동동"
    
    private var allDate : [AllScheduleDate] = []
    
    private var userScore = 0.0
    
    private lazy var statusLabel : UILabel = {
        let label = UILabel()
        label.text = "동동님의 현재 상태"
        label.font = UIFont.pretendard(.medium, size: 15)
        label.textColor = UIColor(red: 0.321, green: 0.321, blue: 0.321, alpha: 1)
        return label
    }()
    
    private let statusIamge : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "WarningStatus")
        return image
    }()
    
    private lazy var statusButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(statusButtonIsClicked), for: .touchUpInside)
        return button
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
        view.backgroundColor = UIColor(hex: "F9F9F9")
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
    
    private let calendar : FSCalendar = {
        let calendar = FSCalendar(frame: .zero)
        calendar.weekdayHeight = 15
        calendar.headerHeight = 0
        //        calendar.appearance.eventDefaultColor = UIColor(hex: "C6C6C6")
        calendar.appearance.eventSelectionColor = UIColor(hex: "FF0000")
        calendar.appearance.headerTitleFont = UIFont.pretendard(.bold, size: 15)
        calendar.appearance.weekdayFont = UIFont.pretendard(.medium, size: 11)
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
    
    private let emptyView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "F9F9F9")
        return view
    }()
    
    
    @objc private func addButtonClicked(_ sender: UIButton) {
        let vc = ModalViewController()
        vc.selectedDate = self.selectedDate
        vc.closeAction = { [weak self] in
            self?.getUser()
            self?.tableView.reloadData()
            self?.view.layoutIfNeeded()
            print("reload 완료")
        }
        self.presentPanModal(vc)
        
    }
    
    override func viewDidLoad() {
        //        self.view.backgroundColor = .blue
        getUser()
        super.viewDidLoad()
        print("-----스케쥴 viewdidload-----")
        //        self.view.backgroundColor = .white
        self.configure()
        setEvents()
        User().getAllSchedule(selectedDate: selectedDate, self)
        getUserPoint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("---- 스케쥴 viewWillAppear-----")
        print("getUser 결과")
        getUser()
        print("getAllSchedule 결과")
        self.tabBarController?.tabBar.isHidden = false
        User().getAllSchedule(selectedDate: selectedDate, self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("---- 스케쥴 viewDidAppear-----")
        getUser()
        User().getAllSchedule(selectedDate: selectedDate, self)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        print("---- 스케쥴 viewWillDisappear-----")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("---- 스케쥴 viewDidDisappear-----")
        
    }
    
    
    @objc private func statusButtonIsClicked() {
        if KeychainService.shared.loadToken() == nil {
            let vc = SignUpViewController()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    private func configure() {
        self.configureStatus()
        self.configureTitleLabel()
        self.configureFSCalendar()
        self.configureEmptyView()
        self.configureNextButton()
        self.configurePreviousButton()
        self.configureAddButton()
        self.configureTableView()
        
    }
    
    private func configureEmptyView() {
        self.view.addSubview(emptyView)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 10),
            emptyView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            emptyView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setEvents() {
        let dfMatter = DateFormatter()
        dfMatter.locale = Locale(identifier: "ko_KR")
        dfMatter.dateFormat = "yyyyMMdd"
        
        guard let myFirstEvent = dfMatter.date(from: selectedDate) else {return}
        
        redEvents = [myFirstEvent]
    }
    
    func setBlueEvents() {
        let dfMatter = DateFormatter()
        dfMatter.locale = Locale(identifier: "ko_KR")
        dfMatter.dateFormat = "yyyyMMdd"
        
        guard let myFirstEvent = dfMatter.date(from: selectedDate) else {return}
        
        blueEvents = [myFirstEvent]
    }
    
    private func getUser() {
        if KeychainService.shared.loadToken() != nil {
            User().getUserName(self)
            self.view.layoutIfNeeded()
        } else {
            print("토큰 없음")
            User().getUserName(self)
            self.statusLabel.text = "로그인이 필요해요!"
            self.statusIamge.image = UIImage(named: "loginStatus")
        }
        
    }
    
    func didSuccess(_ response: UserInfo) {
        if let getUserName = response.userNickname {
            self.statusLabel.text = "\(getUserName)" + "님의 현재 상태"
            self.statusLabel.text = "플러피님의 현재 상태"
            let point = UserDefaults.standard.double(forKey: "userScore")
            switch point {
            case ...15:
                self.statusIamge.image = UIImage(named: "GoodStatus")
            case 16...30:
                self.statusIamge.image = UIImage(named: "CautionStatus")
            case 31...50:
                self.statusIamge.image = UIImage(named: "WarningStatus")
            case 51...:
                self.statusIamge.image = UIImage(named: "DangerStatus")
            default:
                self.statusIamge.image = UIImage(named: "GoodStatus")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.layoutIfNeeded()
            }
            
        } else {
            let point = UserDefaults.standard.double(forKey: "userScore")
            switch point {
            case ...15:
                self.statusIamge.image = UIImage(named: "GoodStatus")
            case 16...30:
                self.statusIamge.image = UIImage(named: "CautionStatus")
            case 31...50:
                self.statusIamge.image = UIImage(named: "WarningStatus")
            case 51...:
                self.statusIamge.image = UIImage(named: "DangerStatus")
            default:
                self.statusIamge.image = UIImage(named: "GoodStatus")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.layoutIfNeeded()
            }
            print("userPoint - \(point)")
        }
    }
    
    private func getUserPoint() {
        guard let userPoint = UserDefaults.standard.string(forKey: "userStore") else {return}
        print("userPoint -\(userPoint)")
    }
    
    func scheduleGetDidSuccess(_ response: [AllScheduleDate]) {
        self.allDate = response
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func deleteScheduleSuccess(_ response: UserScore) {
        print("response - \(response)")
    }
    
    
    private func configureFSCalendar() {
        self.view.addSubview(calendar)
        calendar.delegate = self
        calendar.dataSource = self
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 17),
            calendar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            calendar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            calendar.heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
    private func configureStatus() {
        
        self.view.addSubview(self.statusLabel)
        self.view.addSubview(self.statusIamge)
        self.view.addSubview(self.statusButton)
        
        self.statusLabel.translatesAutoresizingMaskIntoConstraints = false
        self.statusIamge.translatesAutoresizingMaskIntoConstraints = false
        self.statusButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.statusLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 14),
            self.statusLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.statusIamge.centerYAnchor.constraint(equalTo: self.statusLabel.centerYAnchor),
            self.statusIamge.heightAnchor.constraint(equalToConstant: 18),
            self.statusIamge.widthAnchor.constraint(equalToConstant: 54),
            self.statusIamge.leadingAnchor.constraint(equalTo: self.statusLabel.trailingAnchor, constant: 5),
            self.statusButton.centerXAnchor.constraint(equalTo: self.statusIamge.centerXAnchor),
            self.statusButton.centerYAnchor.constraint(equalTo: self.statusIamge.centerYAnchor)
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
        //        tableView.rowHeight = 90
        tableView.separatorStyle = .none
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.emptyView.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureAddButton() {
        self.tableView.addSubview(self.addButton)
        
        //        if KeychainService.shared.loadToken() != nil {
        //            addButton.isHidden = false
        //        } else {
        //            addButton.isHidden = true
        //        }
        
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
        
        return allDate.isEmpty ? 1 : allDate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        
        let result = self.allDate
        
        
        if indexPath.row < result.count {
            let task = result[indexPath.row]
            let time = String(task.scheduleTime)
            
            let prefix = String(time.prefix(2))
            let suffix = String(time.suffix(2))
            var numPrefix = Int(prefix)!
            let otherPrefix = String(time.prefix(1))
            
            if numPrefix > 12 {
                numPrefix -= 12
                let result = "오후 \(numPrefix):\(suffix)"
                cell.timeLabel.text = result
            } else {
                let result = "오전 0\(otherPrefix):\(suffix)"
                cell.timeLabel.text = result
            }
            
            cell.taskLabel.text = task.scheduleContent
            cell.taskLabel.font = UIFont.pretendard(.semiBold, size: 18)
            cell.taskLabel.textColor = UIColor(hex: "2D2D2D")
            
            
            cell.selectionStyle = .none
            
            switch task.stressStep {
            case ..<5:
                cell.statusIcon.image = UIImage(named: "4")
            case 5:
                cell.statusIcon.image = UIImage(named: "0")
            case 6...:
                cell.statusIcon.image = UIImage(named: "-4")
            default:
                cell.statusIcon.image = UIImage(named: "0")
            }
        } else {
            // 인덱스가 유효하지 않을 때에는 기본 UITableViewCell을 반환합니다.
            let taskCell : UITableViewCell = {
                let cell = TaskTableViewCell()
                cell.selectionStyle = .none
                return cell
            }()
            return taskCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if allDate.isEmpty {
                self.tableView.reloadData()
                
            } else if indexPath.row == 0 && indexPath.row + 1 == allDate.count {
                let id = allDate[indexPath.row].id
                tableView.beginUpdates()
                
                
                
                allDate.remove(at: indexPath.row)
                User().deleteSchedule(id: id, self)
                
                tableView.endUpdates()
                
                
                self.tableView.reloadData()
            } else {
                let id = allDate[indexPath.row].id
                
                
                
                tableView.beginUpdates()
                
                
                tableView.deleteRows(at: [indexPath], with: .fade)
                allDate.remove(at: indexPath.row)
                User().deleteSchedule(id: id, self)
                
                tableView.endUpdates()
                
            }
        } else if editingStyle == .insert {
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if allDate.isEmpty {
            
        } else {
            let vc = EditModalViewController()
            vc.selectedDate = self.selectedDate
            vc.closeEditAction = { [weak self] in
                self?.getUser()
                self?.tableView.reloadData()
                self?.view.layoutIfNeeded()
                print("reload 완료")
            }
            vc.index = indexPath.row
            self.presentPanModal(vc)
        }
        self.setBlueEvents()
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
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        calendar.appearance.titleTodayColor = UIColor(hex: "2D2D2D")
        selectedDate = date.toString()
        setEvents()
        User().getAllSchedule(selectedDate: selectedDate, self)
        
    }
    
    // 이벤트 닷 표시 개수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.grayEvents.contains(date) {
            return 1
        }
        if self.redEvents.contains(date) {
            return 1
        }
        if self.blueEvents.contains(date) {
            return 1
        }
        
        return 0
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        if self.grayEvents.contains(date) {
            return [UIColor(hex: "C6C6C6")]
        }
        if self.redEvents.contains(date) {
            return [UIColor(hex: "FF0000")]
        }
        if self.blueEvents.contains(date) {
            return [UIColor(hex: "2276F0")]
        }
        
        return nil
    }
    
    
}

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: self)
    }
    
    func toStr() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a hh:mm"
        return dateFormatter.string(from: self)
    }
}
