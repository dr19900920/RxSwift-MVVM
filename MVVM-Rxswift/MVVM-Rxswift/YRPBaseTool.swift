//
//  YRPBaseTool.swift
//  MBSocial
//
//  Created by 王伟贺 on 16/1/8.
//  Copyright © 2016年 yirupay. All rights reserved.
//

import UIKit

class YRPBaseTool: NSObject {
    /// 创建实例常量
    static let shareTools = YRPBaseTool()
    
    func requestUrl(url: UrlParameter) -> String {
        return kBaseUrl + url.rawValue
    }
    
}
