//
//  SessionManager+Observable.swift
//  VladimirZivanovCV
//
//  Created by Vladimir Zivanov on 8/2/19.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

struct DecodableResponse<Model: Decodable> {
    let data: Data
    let model: Model
}

extension Session {
    func makeObservable<Model: Decodable>(withURL url: URLConvertible, jsonDecoder: JSONDecoder) -> Observable<DecodableResponse<Model>> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onCompleted()
                return Disposables.create()
            }

            self.request(url)
                .validate(statusCode: 200..<300)
                .responseData { response in
                switch response.result {
                case .failure(let error):
                    observer.onError(error)
                case .success(let data):
                    // try to decode the model
                    do {
                        let model = try jsonDecoder.decode(Model.self, from: data)
                        observer.onNext(DecodableResponse(data: data, model: model))
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                }
            }
            return Disposables.create()
        }
    }
}
