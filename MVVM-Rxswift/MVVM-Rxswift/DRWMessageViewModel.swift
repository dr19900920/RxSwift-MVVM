//
//  DRWMessageViewModel.swift
//  MVVM-Rxswift
//
//  Created by dengrui on 16/5/12.
//  Copyright © 2016年 dengrui. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class DRWMessageViewModel: NSObject {
    
    lazy var list = [DRResult<DRWMessageModel>]()
    
    var page: Int = 1
    
    func loadMessage(isPullupRefresh: Bool) -> Observable<Bool> {
        if isPullupRefresh {
            page += 1
        } else {
            page = 1
        }
        return DRRequestJSONModel(URLString: URLParameter.Msg, parameters: ParametersAPI.Msg(userId: "32324157").parameters!)
            /**
            *  回到主线程
            */
            .observeOn(MainScheduler.instance)
            /**
            *  数据转模型
            */
            .mapSwiftyArray(DRResult<DRWMessageModel>)
            .shareReplay(1)
            /**
            *  如果出错返回空数组
            */
            .catchErrorJustReturn([])
            .map({ [weak self] result in
                if isPullupRefresh {
                    // 将新数据拼接在现有数组的末尾
                    self?.list += result
                    if result.count > 0 {
                        return true
                    } else {
                        return false
                    }
                } else {
                    // 初始刷新&下拉刷新
                    self?.list = result
                    
                    return true
                }
                })
    }
}
