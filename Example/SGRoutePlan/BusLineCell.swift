//
//  BusLineCell.swift
//  imapMobile
//
//  Created by 吴小星 on 16/5/31.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit
import SnapKit

class BusLineCell: UITableViewCell {

    var typeIcon        :UIImageView!//图标
    var actionLabel     :UILabel!//线路名称
    var distanceLabel   :UILabel!//距离或者站数
    var upLineView      :UIView!//上划线
    var downLineView    :UIView!//下划线
    var line            :UIView!
    var leftLineView    :UIView!
    var rightLineView   :UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.contentView.backgroundColor = UIColor.whiteColor()
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        typeIcon = UIImageView()
        self.contentView.addSubview(typeIcon)
        
        actionLabel = UILabel()
        self.contentView.addSubview(actionLabel)
        
        distanceLabel = UILabel()
        self.contentView.addSubview(distanceLabel)
        
        upLineView = UIView()
        self.contentView.addSubview(upLineView)
        
        downLineView = UIView()
        self.contentView.addSubview(downLineView)
        
        leftLineView = UIView()
        self.contentView.addSubview(leftLineView)
        
        rightLineView = UIView()
        self.contentView.addSubview(rightLineView)
        
        line = UIView()
        self.contentView.addSubview(line)
        
        leftLineView.snp_makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp_left)
            make.top.equalTo(self.contentView.snp_top)
            make.bottom.equalTo(self.contentView.snp_bottom)
            make.width.equalTo(1)
        }
       leftLineView.backgroundColor = UIColor.grayColor()
        
        rightLineView.snp_makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp_right)
            make.top.equalTo(self.contentView.snp_top)
            make.bottom.equalTo(self.contentView.snp_bottom)
            make.width.equalTo(1)
            
        }
        rightLineView.backgroundColor = UIColor.grayColor()
        line.snp_makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp_left)
            make.right.equalTo(self.contentView.snp_right)
            make.bottom.equalTo(self.contentView.snp_bottom)
            make.height.equalTo(1)
        }
        line.backgroundColor = UIColor.grayColor()
        line.hidden = true
        
        upLineView.snp_makeConstraints(closure: { (make) in
            
            make.top.equalTo(self.contentView.snp_top)
            make.left.equalTo(self.contentView.snp_left).offset(15)
            make.width.equalTo(2)
            make.bottom.equalTo(self.typeIcon.snp_top)
            make.height.equalTo(self.downLineView.snp_height)
            
        })
        upLineView.backgroundColor = UIColor.grayColor()
        
        
        typeIcon.snp_makeConstraints(closure: {(make) in
            
            make.centerX.equalTo(self.upLineView.snp_centerX)
            make.top.equalTo(self.upLineView.snp_bottom)
            make.bottom.equalTo(self.downLineView.snp_top)
            make.width.equalTo(10)
            make.height.equalTo(13)
        })
        
        
        downLineView.snp_makeConstraints(closure: {(make) in
            
            make.top.equalTo(self.typeIcon.snp_bottom)
            make.centerX.equalTo(self.upLineView.snp_centerX)
            make.bottom.equalTo(self.contentView.snp_bottom)
            make.width.equalTo(2)
            make.height.equalTo(self.upLineView.snp_height)
        })
        downLineView.backgroundColor = UIColor.grayColor()
        
        actionLabel.snp_makeConstraints(closure: {(make) in
            
            make.centerY.equalTo(self.typeIcon.snp_centerY)
            make.left.equalTo(self.typeIcon.snp_right).offset(15)
            make.height.equalTo(20)
            make.right.equalTo(self.distanceLabel.snp_left)
        })
        actionLabel.textAlignment = .Left
        actionLabel.textColor = UIColor(hexString: "#838383")
        actionLabel.font = UIFont.systemFontOfSize(13)
        actionLabel.numberOfLines = 0
        actionLabel.lineBreakMode = .ByWordWrapping
        
        
        distanceLabel.snp_makeConstraints(closure: {(make) in
            
            make.centerY.equalTo(self.typeIcon.snp_centerY)
            make.right.equalTo(self.contentView.snp_right).offset(-15)
            make.height.equalTo(20)
            make.left.equalTo(self.actionLabel.snp_right)
            make.width.equalTo(80)
            
        })
        distanceLabel.textAlignment = .Right
        distanceLabel.textColor = UIColor(hexString: "#838383")
        distanceLabel.font = UIFont.systemFontOfSize(13)
        
        self.backgroundColor = UIColor.whiteColor()
        self.selectionStyle = .None
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
