//
//  YRPSeverApi.swift
//  MBSocial
//
//  Created by dengrui on 16/1/6.
//  Copyright © 2016年 yirupay. All rights reserved.
//

import Foundation

let kBaseUrl = "http://api.tongchengyuan.net/api/"

enum UrlParameter: String {
    case Msg = "load_msg_list_new.jsp"
}

enum ParametersAPI {
    case Msg(userId: String)
}

extension ParametersAPI {
    var parameters: [String: AnyObject]? {
        switch self {
        case Msg(let userId):
            return ["userId":userId]
        }
    }
}