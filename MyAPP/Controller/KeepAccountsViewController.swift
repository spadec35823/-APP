//
//  KeepAccountsViewController.swift
//  MyAPP
//
//  Created by user on 2020/6/15.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import YYCalendar
class KeepAccountsViewController: UIViewController {
    
    @IBOutlet weak var oneBtn: UIButton!
    @IBOutlet weak var twoBtn: UIButton!
    @IBOutlet weak var threeBtn: UIButton!
    @IBOutlet weak var fourBtn: UIButton!
    @IBOutlet weak var fiveBtn: UIButton!
    @IBOutlet weak var sixBtn: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var CalendarBtn: UIButton!
    @IBOutlet weak var cashBtn: UIButton!
    @IBOutlet weak var creditCard: UIButton!
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var markTextField: UITextField!
    
    var myBtnArr = [UIButton]()
    
    var myPayBtnArr = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myBtnArr = [oneBtn,twoBtn,threeBtn,fourBtn,fiveBtn,sixBtn]
        
        dateLabel.text =  getToday()
        
        if self.restorationIdentifier == "pay" {
            myPayBtnArr = [cashBtn,creditCard]
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black,NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-medium", size: 22)!]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func cancelBtnOnClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func calendarBtnOnClick(_ sender: Any) {
        let calendar = YYCalendar(normalCalendarLangType: .CHN, date: getToday(), format: "yyyy-MM-dd") { date in
            self.dateLabel.text = date
        }
        calendar.show()
    }
    
    @IBAction func okBtnOnClick(_ sender: Any) {
        if moneyTextField.text == "" {return}
        var myType = -1
        var myPayType = -1
        for btn in myBtnArr {
            if btn.isSelected {
                myType = btn.tag
                break
            }
        }
        if self.restorationIdentifier == "pay" {
            for btn in myPayBtnArr {
                if btn.isSelected {
                    myPayType = btn.tag
                    break
                }
            }
            
            if myType == -1 || myPayType == -1 {
                return
            }
            
            SQLiteManager.shareManger().insertData(type: "\(myType)", money: (moneyTextField.text! as NSString).integerValue, mark: markTextField.text!, payType: "\(myPayType)", time: dateLabel.text!, moneyType: self.restorationIdentifier == "pay" ? 1 : 2)
        } else {
            SQLiteManager.shareManger().insertData(type: "\(myType)", money: (moneyTextField.text! as NSString).integerValue, mark: markTextField.text!, payType: "\(0)", time: dateLabel.text!, moneyType: self.restorationIdentifier == "pay" ? 1 : 2)
        }
        NotificationCenter.default.post(name: .RefreshMainTableView, object: nil)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // 點擊空白處關閉鍵盤
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func choeseBtn(_ sender: UIButton) {
        for btn in myBtnArr {
            if sender.tag == btn.tag {
                sender.isSelected = true
                sender.backgroundColor = .orange
            } else {
                btn.isSelected = false
                btn.backgroundColor = #colorLiteral(red: 0.8446042538, green: 0.8351492882, blue: 0.8264101148, alpha: 1)
            }
        }
    }
    
    @IBAction func payType(_ sender: UIButton) {
        for btn in myPayBtnArr {
            if sender.tag == btn.tag {
                sender.isSelected = true
                sender.backgroundColor = .orange
            } else {
                btn.isSelected = false
                btn.backgroundColor = .clear
            }
        }
    }
}
