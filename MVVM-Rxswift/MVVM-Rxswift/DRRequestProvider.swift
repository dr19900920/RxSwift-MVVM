//
//  DRRequestProvider.swift
//  MVVM-Rxswift
//
//  Created by dengrui on 16/8/8.
//  Copyright © 2016年 dengrui. All rights reserved.
//

import UIKit
import RxSwift
import RxAlamofire
import Alamofire
import SwiftyJSON
import RxCocoa

let kBaseUrl = "http://api.tongchengyuan.net/api/"
let disposeBag = DisposeBag()

public enum URLParameter: String {

    case Msg = "load_msg_list_new.jsp"
}

enum ParametersAPI {
    case Msg(userId: String)
}

private func baseURL(urlString: String) -> String {
    return kBaseUrl + "\(urlString)"
}

extension ParametersAPI {
    var parameters: [String: AnyObject]? {
        switch self {
        case Msg(let userId):
            return ["userId":userId]
        }
    }
}

public func DRRequestJSONModel(method: Alamofire.Method = .GET,
    URLString: URLParameter,
    parameters: Dictionary<String, AnyObject>?,
    encoding: Alamofire.ParameterEncoding = .URL)
    -> Observable<String>
{
    let urlString = baseURL(URLString.rawValue)
    let paramDic: [String: AnyObject] = ["request":["params":parameters!]]
    print("--------------request--------------\r\(urlString)")
    print(paramDic)
    return string(method, urlString, parameters: paramDic, encoding: encoding)
}