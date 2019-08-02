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

/// View model is injected into a view controller under a protocol.
protocol HomeViewModelProtocol {
    /// Whether view should display a loading indicator
//    var isLoading: Observable<Bool> { get }

    /// Whether view should display an error
    var apiError: PublishSubject<Void> { get }

    /// Candidate's name
    var name: Observable<String?> { get }

    /// Candidate's job title
    var title: Observable<String?> { get }

    /// Candidate's contact info
//    var contactInfo: Observable<ContactInfo?> { get }

    /// Table view section models
    var sections: Observable<[HomeSectionModel]> { get }

    /// Load CV from server
    func getCV()

//    /// Call candidate's phone number
//    func callPhone()
//
//    /// Send email to the candidate
//    func sendEmail()
}

final class HomeViewModel: HomeViewModelProtocol {

    private let service: CVServiceProtocol
    private let cvBehaviorRelay = BehaviorRelay<CVModel?>(value: nil)
    private let isLoadingRelay = BehaviorRelay(value: false)
    private let disposeBag = DisposeBag()

    let apiError = PublishSubject<Void>()

    var name: Observable<String?> {
        return cvBehaviorRelay.map { $0?.name }
    }

    var title: Observable<String?> {
        return cvBehaviorRelay.map { $0?.title }
    }

    var sections: Observable<[HomeSectionModel]> {
        return cvBehaviorRelay
            .compactMap { $0 }
            .map { HomeSectionBuilder(model: $0).makeSections() }
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
        })
            .disposed(by: disposeBag)
    }

}
