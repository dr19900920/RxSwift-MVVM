//
//  Observable+SwiftyJSON.swift
//  MBSocial
//
//  Created by dengrui on 16/5/11.
//  Copyright © 2016年 yirupay. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON
/**
 *  JSON转换错误
 */
struct DRSwiftyJSONError : ErrorType {
    let domain: String
    let code: Int
    let message: String
    
    
    var _domain: String {
        return domain
    }
    
    var _code: Int {
        return code
    }
    
    var _message: String {
        return message
    }
}

// MARK: - 扩展ObservableType 转换String为JSON JSON转换成String
public extension ObservableType where E == String {
    
    public func mapSwiftyJSON() -> Observable<JSON> {
        return flatMap { response -> Observable<JSON> in

            if let dataFromString = response.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                let json = JSON(data: dataFromString)
                return Observable.just(json);
            } else {
                throw DRSwiftyJSONError(domain:"SwiftyJSON",code:100,message:"JSON转换错误");
            }
        }
    }
    
    
    public func mapSwiftyObject<T: DRSwiftyJSONAble>(type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in

            if let dataFromString = response.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                let json = JSON(data: dataFromString)
                
                guard let mappedObject = T(jsonData: json) else {
                    throw DRSwiftyJSONError(domain:"SwiftyJSON",code:101,message:"对象转换错误")
                }
                return Observable.just(mappedObject)
            } else {
                throw DRSwiftyJSONError(domain:"SwiftyJSON",code:100,message:"JSON转换错误")
            }
        }
    }
    
    
    public func mapSwiftyArray<T: DRSwiftyJSONAble>(type: T.Type) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
//            print(response)
            if let dataFromString = response.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                let json = JSON(data: dataFromString)
                /// flatMap将数组变换成[T]
                let mappedObjectsArray = json.arrayValue.flatMap { T(jsonData: $0) }
                return Observable.just(mappedObjectsArray)
            } else {
                throw DRSwiftyJSONError(domain:"SwiftyJSON",code:100,message:"JSON转换错误")
            }
        }
    }
    
}