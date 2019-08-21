//
//  APIRequestRetrier.swift
//  VladimirZivanovCV
//
//  Created by Vladimir Zivanov on 8/21/19.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import Foundation
import Alamofire

class APIRequestRetrier: RequestInterceptor {
    let numberOfRetries: UInt = 1
    let retryDelay: TimeInterval = 1.0

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        func retry() {
            completion(.retryWithDelay(retryDelay))
        }

        func dontRetry() {
            completion(.doNotRetry)
        }

        guard request.retryCount < numberOfRetries else {
            dontRetry()
            return
        }
        guard let response = request.response else {
            request.request?.httpMethod == HTTPMethod.get.rawValue ? retry() : dontRetry()
            return
        }
        switch response.statusCode {
        case 500...599:
            retry()
        default:
            dontRetry()
        }
    }
}
