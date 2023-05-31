//
//  MyPageViewModel.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/30.
//

import Foundation
import RxSwift
import RxCocoa

final class MyPageViewModel: RxViewModel {
    
    private let _tapMyInfo = PublishRelay<Void>()
    func tapMyInfo() {
        self._tapMyInfo.accept(())
    }
    
    private let _tapPushSetting = PublishRelay<Void>()
    func tapPushSetting() {
        self._tapPushSetting.accept(())
    }
    
    private let _tapNotice = PublishRelay<Void>()
    func tapNotice() {
        self._tapNotice.accept(())
    }
    
    private let _tapInquire = PublishRelay<Void>()
    func tapInquire() {
        self._tapInquire.accept(())
    }
    
    // MARK: Output
    private let _showMyInfo = PublishRelay<Void>()
    var showMyInfoView: Observable<Void> {
        return self._showMyInfo.asObservable()
    }
    
    private let _showPushSetting = PublishRelay<Void>()
    var showPushSettingView: Observable<Void> {
        return self._showPushSetting.asObservable()
    }
    
    private let _showNotice = PublishRelay<Void>()
    var showNoticeView: Observable<Void> {
        return self._showNotice.asObservable()
    }
    
    private let _showInquire = PublishRelay<Void>()
    var showInquireView: Observable<Void> {
        return self._showInquire.asObservable()
    }
    
    override func bind() {
        
        self._tapMyInfo
            .withUnretained(self)
            .bind(onNext: { $0._showMyInfo.accept($1) })
            .disposed(by: self.disposeBag)
        
        self._tapPushSetting
            .withUnretained(self)
            .bind(onNext: { $0._showPushSetting.accept($1) })
            .disposed(by: self.disposeBag)
        
        self._tapNotice
            .withUnretained(self)
            .bind(onNext: { $0._showNotice.accept($1) })
            .disposed(by: self.disposeBag)
        
        self._tapInquire
            .withUnretained(self)
            .bind(onNext: { $0._showInquire.accept($1) })
            .disposed(by: self.disposeBag)
    }
}
