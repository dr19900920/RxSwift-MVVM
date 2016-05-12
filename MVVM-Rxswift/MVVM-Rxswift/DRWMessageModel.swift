//
//  DRWMessageModel.swift
//  tcy
//
//  Created by dengrui on 16/4/28.
//  Copyright © 2016年 dengrui. All rights reserved.
//

import UIKit
import SwiftyJSON

class DRWMessageModel: DRSwiftyJSONAble {
    
    var msgnum: Int!
    
    var noticenum: String!
    
    var icon: String!
    
    var addtime: String!
    
    var bt: String!
    
    var hashead: Bool!
    
    var imgurl: String!
    
    var nickname: String!
    
    var msgid: Int!
    
    var sendid: Int!
    
    var show: String!
    
    var status: Int!
    
    var type: Int!
    
    var uid: Int!
    
    var version: Int!
    
    required init?(jsonData:JSON){
        self.msgnum = jsonData["msgnum"].intValue
        self.noticenum = jsonData["noticenum"].stringValue
        self.icon = jsonData["icon"].stringValue
        self.addtime = jsonData["addtime"].stringValue
        self.bt = jsonData["bt"].stringValue
        self.hashead = jsonData["hashead"].boolValue
        self.imgurl = jsonData["imgurl"].stringValue
        self.nickname = jsonData["nickname"].stringValue
        self.msgid = jsonData["msgid"].intValue
        self.sendid = jsonData["sendid"].intValue
        self.show = jsonData["show"].stringValue
        self.status = jsonData["status"].intValue
        self.type = jsonData["type"].intValue
        self.uid = jsonData["uid"].intValue
        self.version = jsonData["version"].intValue
    }
    
    
}
