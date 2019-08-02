//
//  HomeSectionModel.swift
//  VladimirZivanovCV
//
//  Created by Vladimir Zivanov on 8/2/19.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import Foundation
import RxDataSources

/// Represents possible table view cell types.
enum HomeCellModelType {
//    case summary(String)
//    case skill(title: String, skills: [String])
//    case company(CompanyCellModel)
    case education(EducationCellViewModel)
}

/// Represents table view section
struct HomeSectionModel: SectionModelType {
    var headerTitle: String?
    var items: [HomeCellModelType]

    init(original: HomeSectionModel, items: [HomeCellModelType]) {
        self = original
        self.items = items
    }

    init(items: [HomeCellModelType], headerTitle: String? = nil) {
        self.items = items
        self.headerTitle = headerTitle
    }

}
