//
//  HomeViewController.swift
//  VladimirZivanovCV
//
//  Created by Vladimir Zivanov on 8/1/19.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class HomeViewController: UIViewController, StoryboardInitializable {

    var viewModel: HomeViewModelProtocol!

    @IBOutlet private var phoneButtonItem: UIBarButtonItem!
    @IBOutlet private var mailButtonItem: UIBarButtonItem!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var headerView: HomeTableHeaderView!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupBindings()
        viewModel.getCV()
    }

}

private extension HomeViewController {
    func setupBindings() {
        setupContactInfoBindings()
        setupHeaderBindings()
        setupTableViewBindings()

        viewModel.apiError.subscribe(onNext: { [weak self] _ in
            self?.showError()
        }).disposed(by: disposeBag)

//        viewModel.isLoading.bind(to: rx.showsActivityView)
//            .disposed(by: disposeBag)
    }

    func setupContactInfoBindings() {
        viewModel.contactInfo
            .map { $0 != nil }
            .bind(to: phoneButtonItem.rx.isEnabled)
            .disposed(by: disposeBag)

        viewModel.contactInfo
            .map { $0 != nil }
            .bind(to: mailButtonItem.rx.isEnabled)
            .disposed(by: disposeBag)

        phoneButtonItem.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.callPhone()
            }).disposed(by: disposeBag)

        mailButtonItem.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.sendEmail()
            }).disposed(by: disposeBag)
    }

    func setupHeaderBindings() {
        viewModel.name
            .bind(to: headerView.nameLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.title
            .bind(to: headerView.titleLabel.rx.text)
            .disposed(by: disposeBag)
    }

    func setupTableViewBindings() {
        tableView.refreshControl?.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.refreshControl?.endRefreshing()
                self?.viewModel.getCV()
            })
            .disposed(by: disposeBag)

        let dataSource = RxTableViewSectionedReloadDataSource<HomeSectionModel>(configureCell: { (_, tableView, _, cellModelType) -> UITableViewCell in
            return tableView.dequeueCell(forType: cellModelType)
        }, titleForHeaderInSection: { (dataSource, index) -> String? in
            return dataSource.sectionModels[index].headerTitle?.uppercased()
        })
        viewModel.sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

private extension HomeViewController {
    func setupTableView() {
        tableView.refreshControl = UIRefreshControl()
    }

    func showError() {
        let alert = UIAlertController(title: Strings.Error.title, message: Strings.Error.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Strings.Error.buttonTitle, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

private extension UITableView {
    func dequeueCell(forType type: HomeCellModelType) -> UITableViewCell {
        switch type {
        case .summary(let summary):
            let cell = dequeueReusableCell(className: SummaryTableViewCell.self)
            cell.bind(summary)
            return cell
        case .skill(let skillViewModel):
            let cell = dequeueReusableCell(className: SkillTableViewCell.self)
            cell.bind(skillViewModel)
            return cell
        case .company(let companyViewModel):
            let cell = dequeueReusableCell(className: CompanyTableViewCell.self)
            cell.bind(companyViewModel)
            return cell
        case .education(let educationCellViewModel):
            let cell = dequeueReusableCell(className: EducationTableViewCell.self)
            cell.bind(educationCellViewModel)
            return cell
        }
    }
}
