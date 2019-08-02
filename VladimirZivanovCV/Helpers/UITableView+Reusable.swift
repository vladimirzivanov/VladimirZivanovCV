//
//  UITableView+Reusable.swift
//  VladimirZivanovCV
//
//  Created by Vladimir Zivanov on 8/2/19.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import UIKit

extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(className: T.Type) -> T {
        let name = "\(T.self)"
        guard let cell = self.dequeueReusableCell(withIdentifier: name) as? T else {
            fatalError("Error: dequeueReusableCell: \(NSStringFromClass(T.self)) is not \(T.self)")
        }
        return cell
    }

}
