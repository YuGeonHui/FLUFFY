//
//  OnBoardingViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/03.
//

import UIKit
import SwiftRichString

final class OnBoardingViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    
    private let pageControl = UIPageControl()
    
    private let skipLabel = UILabel()
    
//    private var onBoardingViews: [OnBoardingView] = []
//    
//    private var onBoardingInfos = [OnBoardingView(title: "반가워요, 제 이름은 플러피에요! ", desc: "지금부터 당신의 일상에 가이드가 되어드릴게요!\n저와 함께 번아웃을 예방하러 가볼까요?", image: UIImage(named: "intro1")), OnBoardingView(title: "스트레스 지수 입력으로 셀프 피드백!", desc: "일정관리와 동시에 스트레스 지수를 측정하며\n스스로 번아웃을 예방할 수 있어요.", image: UIImage(named: "intro2")), OnBoardingView(title: "한눈에 알 수 있는 나의 상태", desc: "누적된 스트레스 지수에 따라 플러피를 통해\n나의 상태를 확인하고 필요한 행동을 추천받아요.", image: UIImage(named: "intro3"))]
    
    private enum Styles {
        
        static let skip: Style = Style {
            $0.font = UIFont.pretendard(.semiBold, size: 14)
            $0.color = UIColor(hex: "b4b4b4")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: "f9f9f9")
        
        self.scrollView.delegate = self
        
        self.setupViews()
        self.setupAutoLayout()
        self.bindView()
    }
    
    private func setupViews() {
        
        self.view.addSubview(pageControl)
    }
    
    private func setupAutoLayout() {
        
        
    }
    
    private func bindView() {
        
    }
}

extension OnBoardingViewController: UIScrollViewDelegate {
    
}
