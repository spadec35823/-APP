//
//  ViewController.swift
//  MyAPP
//
//  Created by user on 2020/6/12.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var monthText: UILabel!
    @IBOutlet weak var nextMonth: UIButton!
    @IBOutlet weak var lastMonth: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var myData :[moneyRecord]?
    var nowDate = gettimeStamp()
    override func viewDidLoad() {
        super.viewDidLoad()
        SQLiteManager.shareManger().createTable()
        myData = SQLiteManager.shareManger().queryData(date:nowDate)
        formatterMoney(0)
        // Do any additional setup after loading the view.
        self.tableView.register(UINib(nibName:"MainTableViewCell", bundle: nil), forCellReuseIdentifier:"MainTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(refershTableView), name: .RefreshMainTableView, object: nil)
    }
    
    @objc func refershTableView() {
        myData = SQLiteManager.shareManger().queryData(date:nowDate)
        self.tableView.reloadData()
        formatterMoney(0)
    }
    
    func formatterMoney(_ money:Int) {
        SQLiteManager.shareManger().totileCount -= money
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        formatter.numberStyle = .currency
        monthText.text = nowDate + "\r\n TW\(formatter.string(from: NSNumber(value: SQLiteManager.shareManger().totileCount))!)"
    }
    
    @IBAction func leftBtnOnClick(_ sender: Any) {
        nowDate = getLastMonth(nowDate: nowDate)
        refershTableView()
    }
    
    @IBAction func rightBtnOnClick(_ sender: Any) {
        nowDate = getNextMonth(nowDate: nowDate)
        refershTableView()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        cell.model = myData![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if SQLiteManager.shareManger().chartsDeleteData(id: myData![indexPath.row].id) {
                formatterMoney(myData![indexPath.row].money)
                myData?.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

