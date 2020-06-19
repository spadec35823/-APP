//
//  SQLiteManager.swift
//  MyAPP
//
//  Created by user on 2020/6/16.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation
import FMDB
// 数据库管理类
class SQLiteManager: NSObject {
     
    // 创建单例
    private static let manger: SQLiteManager = SQLiteManager()
    class func shareManger() -> SQLiteManager {
        return manger
    }
     
    // 数据库名称
    private let dbName = "KeepDB.db"
     
    // 数据库地址
    lazy var dbURL: URL = {
        // 根据传入的数据库名称拼接数据库的路径
        let fileURL = try! FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask,
                 appropriateFor: nil, create: true)
            .appendingPathComponent(dbName)
        print("数据库地址：", fileURL)
        return fileURL
    }()
     
    // FMDatabase对象（用于对数据库进行操作）
    lazy var db: FMDatabase = {
        let database = FMDatabase(url: dbURL)
        return database
    }()
     
    // FMDatabaseQueue对象（用于多线程事务处理）
    lazy var dbQueue: FMDatabaseQueue? = {
        // 根据路径返回数据库
        let databaseQueue = FMDatabaseQueue(url: dbURL)
        return databaseQueue
    }()
    
    func createTable() {
        let fileManager: FileManager = FileManager.default
        
        // 判斷documents是否已存在該檔案
        if !fileManager.fileExists(atPath: dbURL.path) {
            
            // 開啟連線
            if db.open() {
                let createTableSQL = "create table moneyRecord (id integer primary key autoincrement not null, type text not null, money integer not null, mark text not null, payType text, time datetime not null)"
                db.executeStatements(createTableSQL)
                print("file copy to: \(dbURL.path)")
                db.close()
            }
        } else {
            print("DID-NOT copy db file, file allready exists at path:\(dbURL.path)")
        }
        
    }
    
    func insertData(type:String, money:Int, mark:String, payType:String, time:String) {
        print(db.open())
        if db.open() {
            let insertSQL: String = "INSERT INTO moneyRecord (type, money, mark, payType, time) VALUES('\(type)','\(money)','\(mark)','\(payType)','\(time)')"
            
            if !db.executeUpdate(insertSQL, withArgumentsIn: []) {
                print("Failed to insert initial data into the database.")
                print(db.lastError(), db.lastErrorMessage())
            } else {
                print(">>insert initial data into the database>>>>>")
            }
            
            db.close()
        }
    }
    func queryData() -> [moneyRecord] {
       
        var record = [moneyRecord]()
        if db.open() {
            let querySQL: String = "SELECT * FROM moneyRecord WHERE time BETWEEN '2020-06-01' AND '2020-06-30'"
            
            do {
                let dataLists: FMResultSet = try db.executeQuery(querySQL, values: nil)
                
                while dataLists.next() {
                    let getData = moneyRecord.init(id: Int(dataLists.int(forColumn:"id")), type: dataLists.string(forColumn:"type")!, mark: dataLists.string(forColumn:"mark")!, money: Int(dataLists.int(forColumn:"money")), time: dataLists.string(forColumn:"time")!, payType: dataLists.string(forColumn:"payType")!)
                    record.append(getData)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        return record
    }
}
