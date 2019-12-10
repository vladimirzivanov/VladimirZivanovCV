//
//  HomeViewModel.swift
//  VladimirZivanovCV
//
//  Created by Vladimir Zivanov on 8/1/19.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

typealias ContactInfo = (phone: String, email: String)

/// View model is injected into a view controller under a protocol.
protocol HomeViewModelProtocol {
    /// Whether view should display a loading indicator
    var isLoading: Driver<Bool> { get }

    /// Whether view should display an error
    var apiError: PublishSubject<Void> { get }

    /// Candidate's name
    var name: Driver<String?> { get }

    /// Candidate's job title
    var title: Driver<String?> { get }
    
    /// Candidate's profile picture
    var profileImageUrl: Driver<URL?> { get }

    /// Candidate's contact info
    var contactInfo: Driver<ContactInfo?> { get }

    /// Table view section models
    var sections: Driver<[HomeSectionModel]> { get }

    /// Load CV from server
    func getCV()

    /// Call candidate's phone number
    func callPhone()

    /// Send email to the candidate
    func sendEmail()
}

final class HomeViewModel: HomeViewModelProtocol {

    private let service: CVServiceProtocol
    private let cvBehaviorRelay = BehaviorRelay<CVModel?>(value: nil)
    private let isLoadingRelay = BehaviorRelay(value: false)
    private let disposeBag = DisposeBag()
    
    var isLoading: Driver<Bool> {
        return isLoadingRelay.asObservable()
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
    }

    let apiError = PublishSubject<Void>()

    var name: Driver<String?> {
        return cvBehaviorRelay.map { $0?.name }.asDriver(onErrorJustReturn: nil)
    }

    var title: Driver<String?> {
        return cvBehaviorRelay.map { $0?.title }.asDriver(onErrorJustReturn: nil)
    }
    
    var profileImageUrl: Driver<URL?> {
        return cvBehaviorRelay.map { URL(string: $0?.profileImageUrl ?? "") }.asDriver(onErrorJustReturn: nil)
    }

    var contactInfo: Driver<ContactInfo?> {
        return cvBehaviorRelay.map {
            guard let contactInfo = $0 else { return nil }
            return ContactInfo(phone: contactInfo.contactInfo.phone, email: contactInfo.contactInfo.email)
        }.asDriver(onErrorJustReturn: nil)
    }

    var sections: Driver<[HomeSectionModel]> {
        return cvBehaviorRelay
            .compactMap { $0 }
            .map { HomeSectionBuilder(model: $0).makeSections() }
            .asDriver(onErrorJustReturn: [])
    }

    init(service: CVServiceProtocol) {
        self.service = service
    }

    func getCV() {
        // show loading indicator only if there's no data yet
        if cvBehaviorRelay.value == nil {
            isLoadingRelay.accept(true)
        }
        service.getCV()
            .subscribe(onNext: { [weak self] response in
                guard let self = self else { return }
                self.cvBehaviorRelay.accept(response.model)
                self.isLoadingRelay.accept(false)
                }, onError: { error in
                    self.isLoadingRelay.accept(false)
                    self.apiError.onNext(())
            }).disposed(by: disposeBag)
    }

    func callPhone() {
        // note: doesn't work on a simulator
        guard let phone = cvBehaviorRelay.value?.contactInfo.phone else { return }
        if let url = URL(string: "tel://\(phone)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    func sendEmail() {
        // note: doesn't work on a simulator
        guard let email = cvBehaviorRelay.value?.contactInfo.email else { return }
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
