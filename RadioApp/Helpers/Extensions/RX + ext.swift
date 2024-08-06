//
//  RX.swift
//  RadioApp
//
//  Created by dsm 5e on 03.08.2024.
//

import Foundation
import MediaPlayer
import RxSwift
import RxCocoa

// Обертка для красивого мапинга
extension ObservableType {
    func mapToVoid() -> Observable<Void> {
        return self.map { _ in }
    }
}

// Наблюдаемая за свйоством MPVolumeView
extension Reactive where Base: MPVolumeView {
    var volume: Observable<Float> {
        return Observable.create { observer in
            guard let slider = self.base.subviews.first(where: { $0 is UISlider }) as? UISlider else {
                observer.onCompleted()
                return Disposables.create()
            }

            let disposable = slider.rx.value
                .distinctUntilChanged()
                .subscribe(onNext: { value in
                    observer.onNext(value)
                }, onError: { error in
                    observer.onError(error)
                }, onCompleted: {
                    observer.onCompleted()
                }, onDisposed: {

                })

            return Disposables.create {
                disposable.dispose()
            }
        }
    }
}
