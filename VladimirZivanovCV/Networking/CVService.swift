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
        static let cvURL = "https://gist.githubusercontent.com/vladimirzivanov/decc37cda7b6789f6915577200c3f101/raw/mycv.json"
    }

    private let session: Session

    private static func makeDefaultSession() -> Session {
        let session = Session()
//        sessionManager.retrier = APIRequestRetrier()
        return session
    }

    init(session: Session = CVService.makeDefaultSession()) {
        self.session = session
    }

    func getCV() -> Observable<DecodableResponse<CVModel>> {
        return session.makeObservable(withURL: Const.cvURL, jsonDecoder: JSONDecoder())
    }

}
