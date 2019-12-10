//
//  CVService.swift
//  VladimirZivanovCV
//
//  Created by Vladimir Zivanov on 8/2/19.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

/// Defines interface for CV Service.
protocol CVServiceProtocol {
    func getCV() -> Observable<DecodableResponse<CVModel>>
}

/// Responsible for retrieving the CV from server.
struct CVService: CVServiceProtocol {

    private enum Const {
        static let cvURL = "https://gist.githubusercontent.com/vladimirzivanov/a06f4ea9718a76593368658260a23bc5/raw/myCV.json"
    }

    private let session: Session

    private static func makeDefaultSession() -> Session {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        let session = Session(configuration: configuration, interceptor: APIRequestRetrier())
        return session
    }

    init(session: Session = CVService.makeDefaultSession()) {
        self.session = session
    }

    func getCV() -> Observable<DecodableResponse<CVModel>> {
        return session.makeObservable(withURL: Const.cvURL, jsonDecoder: JSONDecoder())
    }

}
