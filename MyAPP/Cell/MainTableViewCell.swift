//
//  MainTableViewCell.swift
//  MyAPP
//
//  Created by user on 2020/6/12.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    
    var model: moneyRecord? {
        didSet {
            guard model != nil else {
                return
            }
            refreshMessageCell()
        }
    }
    lazy var typeImageView :UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = #imageLiteral(resourceName: "taxi")
        return imageView
    }()
    
    lazy var typeLabel :UILabel = {
        let label = UILabel()
        label.text = "運輸交通 - 計程車"
        return label
    }()
    
    lazy var moneyLabel :UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        label.text = "TW$ 100"
        return label
    }()
    
    lazy var timeLabel :UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.numberOfLines = 0
        label.text = "2020-06-12(週六) 14:58 \r\n 7-Eleven \r\n 個人"
        return label
    }()
    
    lazy var payTypeLabel :UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        label.text = "現金"
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addSubview(typeImageView)
        self.addSubview(typeLabel)
        self.addSubview(moneyLabel)
        self.addSubview(timeLabel)
        self.addSubview(payTypeLabel)
        resetLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func refreshMessageCell() {
        switch model!.type {
        case "1":
            typeImageView.image = #imageLiteral(resourceName: "Food")
            typeLabel.text = "美食"
            self.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            break
        case "2":
            typeImageView.image = #imageLiteral(resourceName: "short")
            typeLabel.text = "衣服"
            self.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            break
        case "3":
            typeImageView.image = #imageLiteral(resourceName: "live")
            typeLabel.text = "住宿"
            self.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            break
        case "4":
            typeImageView.image = #imageLiteral(resourceName: "taxi")
            typeLabel.text = "交通"
            self.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            break
        case "5":
            typeImageView.image = #imageLiteral(resourceName: "play")
            typeLabel.text = "玩樂"
            self.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            break
        default:
            typeImageView.image = #imageLiteral(resourceName: "other")
            typeLabel.text = "其他"
            self.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            break
        }
        
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "yyyy-MM-dd"
        let last = dfmatter.date(from: model!.time)
        let calender = Calendar(identifier:Calendar.Identifier.gregorian)
        let comps = (calender as NSCalendar?)?.components(NSCalendar.Unit.weekday, from: last!)
        var week = ""
        switch comps!.weekday! - 1 {
        case 0:
            week = "週日"
            break
        case 1:
            week = "週一"
            break
        case 2:
            week = "週二"
            break
        case 3:
            week = "週三"
            break
        case 4:
            week = "週四"
            break
        case 5:
            week = "週五"
            break
        case 6:
            week = "週六"
            break
        default:
            break
        }
        
        moneyLabel.text = "TW$ " + "\(model!.money)"
        timeLabel.text = "\(model!.time)(\(week))" + "\r\n" + "\(model!.mark)"
        switch model!.payType  {
        case "0":
            payTypeLabel.text = "收入"
            break
        case "1":
            payTypeLabel.text = "現金"
            break
        case "2":
            payTypeLabel.text = "刷卡"
            break
        default:
            break
        }
        
    }
    
    
    func resetLayout() {
        typeImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.width.height.equalTo(50)
            make.top.equalToSuperview().offset(5)
        }
        
        typeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(typeImageView.snp_right).offset(5)
            make.top.equalTo(typeImageView.snp_top)

        }
        
        moneyLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)

            make.centerY.equalTo(typeLabel.snp_centerY)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(typeLabel.snp_bottom).offset(10)

            make.left.equalTo(typeLabel.snp_left)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        payTypeLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(timeLabel.snp_bottom)
            make.height.equalTo(20)
            make.right.equalToSuperview().offset(-5)
        }
    }
}
