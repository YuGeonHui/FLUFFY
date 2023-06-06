//
//  OnBoardingViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/03.
//

import UIKit
import RxSwift
import RxCocoa

class AppGuideViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.addTarget(self, action: #selector(pageControlValueChanged(_:)), for: .valueChanged)
        return pageControl
    }()
    
    private let nextButton = CommonButtonView(background: UIColor(hex: "89bfff"), title: "시작하기")
    
    private let pageCount = 3
    private var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "f9f9f9")
        
        self.scrollView.delegate = self
       
        self.setupViews()
        self.setupViewControllers()
        self.setupAutoLayout()
        self.bindView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupViews() {
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pageControl)
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = UIColor(hex: "eaeaea")
        pageControl.currentPageIndicatorTintColor = UIColor(hex: "90bdff")
       
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        
        scrollView.frame = UIScreen.main.bounds
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(pageCount), height: UIScreen.main.bounds.height)

        scrollView.alwaysBounceVertical = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isScrollEnabled = true
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(nextButton)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),

            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: nextButton.topAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            nextButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 53),
        ])

        var previousView: UIView?

        for viewController in viewControllers {
            
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(viewController.view)

            NSLayoutConstraint.activate([
                viewController.view.leadingAnchor.constraint(equalTo: previousView?.trailingAnchor ?? scrollView.leadingAnchor),
                viewController.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
                viewController.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                viewController.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])

            previousView = viewController.view
        }

        if let lastView = viewControllers.last?.view {
            lastView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        }
    }

    private func setupViewControllers() {
        for index in 0..<pageCount {
            let viewController = getContentViewController(index: index)
            viewControllers.append(viewController)
        }
    }
    
    private func getContentViewController(index: Int) -> UIViewController {
        switch index {
        case 0:
            return OnBoardingContenViewController(titleText: "반가워요, 제 이름은 플러피에요!", descText: "지금부터 당신의 일상에 가이드가 되어드릴게요!\n저와 함께 번아웃을 예방하러 가볼까요?", image: UIImage(named: "intro1"))
        case 1:
            return OnBoardingContenViewController(titleText: "스트레스 지수 입력으로 셀프 피드백!", descText: "일정관리와 동시에 스트레스 지수를 측정하며\n스스로 번아웃을 예방할 수 있어요.", image: UIImage(named: "intro2"))
        case 2:
            return OnBoardingContenViewController(titleText: "한눈에 알 수 있는 나의 상태", descText: "누적된 스트레스 지수에 따라 플러피를 통해\n나의 상태를 확인하고 필요한 행동을 추천받아요.", image: UIImage(named: "intro3"))
        default:
            return UIViewController()
        }
    }
    
    @objc private func pageControlValueChanged(_ sender: UIPageControl) {
        let pageIndex = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.width * CGFloat(pageIndex), y: 0), animated: true)
    }
    
    private func bindView() {
        
        self.nextButton.rx.tap
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: {
                $0.0.navigationController?.pushViewController(SignUpViewController(), animated: true) })
            .disposed(by: self.disposeBag)
    }
}

extension AppGuideViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(floor(scrollView.contentOffset.x / scrollView.frame.width))
        pageControl.currentPage = pageIndex
    }
}
