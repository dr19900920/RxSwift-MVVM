//
//  DRWMessageViewModel.swift
//  MVVM-Rxswift
//
//  Created by dengrui on 16/5/12.
//  Copyright © 2016年 dengrui. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON
import RxAlamofire

class DRWMessageViewModel: NSObject {
    
    private let disposeBag = DisposeBag()

    var messages: [DRResult<DRWMessageModel>]?
    
    func loadMessage() -> Observable<Bool> {
        let url = YRPBaseTool.shareTools.requestUrl(UrlParameter.Msg)
       return Observable.create { observer -> Disposable in

        string(.GET, url,
            parameters: ParametersAPI.Msg(userId: "32324157").parameters!)
            .observeOn(MainScheduler.instance)
            .mapSwiftyArray(DRResult<DRWMessageModel>)
            .shareReplay(1)
            .subscribe(
                onNext: {[weak self] repos -> Void in
                    self?.messages = repos
                    observer.onCompleted()
                },
                onError: { (error) -> Void in
                    observer.onError(error)
            })
            .addDisposableTo(self.disposeBag)
        return NopDisposable.instance
        }
    }
}
