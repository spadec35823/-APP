//
//  Constant.swift
//  MyAPP
//
//  Created by user on 2020/6/16.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation
//Notificationcenter Name
public extension NSNotification.Name {
    ///
    static let RefreshMainTableView = Notification.Name("RefreshMainTableView")
    
}

func gettimeStamp() -> String {
    //获取当前时间
    let now = Date()
    // 创建一个日期格式器
    let dformatter = DateFormatter()
    dformatter.dateFormat = "yyyy-MM"
    
    //当前时间的时间戳
    let timeInterval:TimeInterval = now.timeIntervalSince1970
    let date = Date(timeIntervalSince1970: timeInterval)
    return dformatter.string(from: date)
}

func getToday() -> String {
    //获取当前时间
    let now = Date()
    // 创建一个日期格式器
    let dformatter = DateFormatter()
    dformatter.dateFormat = "yyyy-MM-dd"
    
    //当前时间的时间戳
    let timeInterval:TimeInterval = now.timeIntervalSince1970
    let date = Date(timeIntervalSince1970: timeInterval)
    return dformatter.string(from: date)
}


func getLastMonth(nowDate: String) -> String {
    var year = nowDate.prefix(4)
    let month = Int(nowDate.suffix(2))
    var myMonth = ""
    if month! - 1 > 0 {
        if month! - 1 < 10 {
            myMonth = "0\(month! - 1)"
        } else {
            myMonth = "\(month! - 1)"
        }
    } else {
        myMonth = "12"
        year = "\((year as NSString).integerValue - 1)"
    }
    return "\(year)-\(myMonth)"
}

func getNextMonth(nowDate: String) -> String {
    var year = nowDate.prefix(4)
    let month = Int(nowDate.suffix(2))
    var myMonth = ""
    if month! + 1 < 12 {
        if month! + 1 < 10 {
            myMonth = "0\(month! + 1)"
        } else {
            myMonth = "\(month! + 1)"
        }
    } else {
        myMonth = "01"
        year = "\((year as NSString).integerValue + 1)"
    }
    return "\(year)-\(myMonth)"
}
