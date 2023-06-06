//
//  PermAgreeViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/06.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftRichString

final class PermAgreeViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private enum Metric {
        
        static let titleBefore: CGFloat = 104
        
        static let titleAfter: CGFloat = 25
        
        static let descAfter: CGFloat = 34
        
        static let dividerAfter: CGFloat = 11
        
        static let subTitleAfter: CGFloat = 3
        
        static let btnHeight: CGFloat = 53
    }
    
    private enum Styles {
        
        static let fluffy: Style = Style {
            $0.font = UIFont.candyBean(.normal, size: 25)
            $0.color = UIColor(hex: "2d2d2d")
            $0.minimumLineHeight = 32
            $0.maximumLineHeight = 32
        }
        
        static let title: Style = Style {
            $0.font = UIFont.pretendard(.bold, size: 25)
            $0.color = UIColor(hex: "2d2d2d")
            $0.minimumLineHeight = 32
            $0.maximumLineHeight = 32
        }
        
        static let desc: Style = Style {
            $0.font = UIFont.pretendard(.medium, size: 15)
            $0.color = UIColor(hex: "656565")
            $0.minimumLineHeight = 23.5
            $0.maximumLineHeight = 23.5
        }
        
        static let subDesc: Style = Style {
            $0.font = UIFont.pretendard(.medium, size: 13)
            $0.color = UIColor(hex: "a1a1a1")
        }
        
        static let subTitle: Style = Style {
            $0.font = UIFont.pretendard(.medium, size: 15)
            $0.color = UIColor(hex: "2d2d2d")
        }
    }
    
    private let titleLabel = UILabel()
    
    private let descLabel = UILabel()
    
    private let dividerView = DividerView()
    
    private let subTitleLabel = UILabel()
    
    private let subDescLabel = UILabel()
    
    private let agreeButton = CommonButtonView(background: UIColor(hex: "000000"), title: "동의하고 시작하기")
    
    override func viewDidLoad() {
        
        self.checkPermission()
        self.setupViews()
        self.setupAutoLayout()
        self.bindView()
        
        self.view.backgroundColor = UIColor(hex: "f9f9f9")
    }
    
    private func setupViews() {
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dividerView.translatesAutoresizingMaskIntoConstraints = false
        self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.subDescLabel.translatesAutoresizingMaskIntoConstraints = false
        self.agreeButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(descLabel)
        self.view.addSubview(dividerView)
        self.view.addSubview(subTitleLabel)
        self.view.addSubview(subDescLabel)
        self.view.addSubview(agreeButton)
        
        let style = StyleXML(base: Styles.title, ["b": Styles.fluffy])
        self.titleLabel.attributedText = "<b>Fluffy</b>앱 사용\n권한에 대해 안내드립니다.".set(style: style)
        self.titleLabel.numberOfLines = 0
        
        self.descLabel.attributedText = "더 나은 서비스의 제공을 위해 사용자에게 서비스의 이용과 관련된 각종 고지를 푸시알림으로 제공할 수 있습니다. 더욱 정확한 서비스 이용을 위해 동의하시는 것을 권장드립니다.\n\n동의 하지 않을 시 언제든지 기기 설정 → 알림에서 변경 할 수 있습니다.".set(style: Styles.desc)
        self.descLabel.numberOfLines = 0
        
        self.subTitleLabel.attributedText = "정확한 스트레스 지수 측정을 위한 확인 알림".set(style: Styles.subTitle)
        self.subDescLabel.attributedText = "매일 지정된 시간에 제공".set(style: Styles.subDesc)
    }
    
    private func setupAutoLayout() {
        
        NSLayoutConstraint.activate([
        
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Metric.titleBefore),
            
            self.descLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.descLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.descLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: Metric.titleAfter),
            
            self.dividerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.dividerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.dividerView.topAnchor.constraint(equalTo: self.descLabel.bottomAnchor, constant: Metric.descAfter),
            self.dividerView.widthAnchor.constraint(equalToConstant: 350),
            self.dividerView.heightAnchor.constraint(equalToConstant: 1),
            
            self.subTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.subTitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.subTitleLabel.topAnchor.constraint(equalTo: self.dividerView.bottomAnchor, constant: Metric.dividerAfter),
            
            self.subDescLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.subDescLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.subDescLabel.topAnchor.constraint(equalTo: self.subTitleLabel.bottomAnchor, constant: Metric.subTitleAfter),
            
            self.agreeButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.agreeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.agreeButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            self.agreeButton.heightAnchor.constraint(equalToConstant: Metric.btnHeight)
        ])
    }
    
    private func bindView() {
        
        self.agreeButton.buttonTapped
            .withUnretained(self)
            .bind(onNext: { $0.0.agreeTapped() })
            .disposed(by: self.disposeBag)
    }
}

extension PermAgreeViewController {
    
    private func checkPermission() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                self.scheduleLocalNotification()
            }
        }
    }
    
    private func agreeTapped() {
        
        UserDefaults.standard.isPermAgreed = true
        
        // 앱 최초 TabBarViewController() 먼저 깔고 가야되지만, 시간이슈...
        let mainViewController = TabBarViewController()
        mainViewController.modalPresentationStyle = .fullScreen
        
        self.present(mainViewController, animated: true)
    }
    
    func scheduleLocalNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "오늘 하루 고생하셨어요 :)"
        content.body = "스트레스 지수가 변경 된 일정은 없는지 확인 해보세요!"
        content.sound = UNNotificationSound.default
        
        if let imageURL = Bundle.main.url(forResource: "fluffy_logo", withExtension: "png") {
            let attachment = try? UNNotificationAttachment(identifier: "imageAttachment", url: imageURL, options: nil)
            if let attachment = attachment {
                content.attachments = [attachment]
            }
        }
        
        var dateComponents = DateComponents()
        dateComponents.hour = 22
        dateComponents.minute = 00
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("로컬 알림 예약 실패: \(error)")
            } else {
                print("로컬 알림 예약 성공")
            }
        }
    }
}
