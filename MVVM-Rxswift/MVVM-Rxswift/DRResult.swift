//
//  DRResult.swift
//  MBSocial
//
//  Created by dengrui on 16/5/11.
//  Copyright © 2016年 yirupay. All rights reserved.
//

import UIKit
import SwiftyJSON

class DRResult<T: DRSwiftyJSONAble>: DRSwiftyJSONAble {
    
    var element: T?
    
    required init?(jsonData:JSON){

        self.element = T(jsonData: jsonData)
    }
}
