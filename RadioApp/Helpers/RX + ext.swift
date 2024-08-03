//
//  RX.swift
//  RadioApp
//
//  Created by dsm 5e on 03.08.2024.
//

import RxSwift

extension ObservableType {
    func mapToVoid() -> Observable<Void> {
        return self.map { _ in }
    }
}
