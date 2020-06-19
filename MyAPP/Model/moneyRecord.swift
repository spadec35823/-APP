//
//  moneyRecord.swift
//  MyAPP
//
//  Created by user on 2020/6/16.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation

class moneyRecord: NSObject {
    
    var id: Int
    var type: String
    var mark: String
    var money: Int
    var time: String
    var payType: String
    
    init(id: Int, type: String, mark: String, money: Int, time: String, payType: String) {
        self.id = id
        self.type = type
        self.mark = mark
        self.money = money
        self.time = time
        self.payType = payType
    }
}
