//
//  BusLineSectionView.swift
//  imapMobile
//
//  Created by 吴小星 on 16/5/31.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit

class BusLineSectionView: UITableViewHeaderFooterView {
    var contrainView :UIView!
    var lineNameLb   :UILabel!//路线名称
    var lineInfoLb   :UILabel!//路线详情名称
    var arrowImg     :UIImageView!//箭头
    
    var isOpen: Bool = false {
        didSet {
            rotateIndicate()
        }
    }
    

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColor.whiteColor()
        
        contrainView = UIView()
        self.contentView.addSubview(contrainView)
        
        lineNameLb = UILabel()
        contrainView.addSubview(lineNameLb)
        
        lineInfoLb = UILabel()
        contrainView.addSubview(lineInfoLb)
        
        arrowImg = UIImageView()
        contrainView.addSubview(arrowImg)
        
        
        contrainView.snp_makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp_top).offset(5)
            make.left.equalTo(self.contentView.snp_left).offset(5)
            make.right.equalTo(self.contentView.snp_right).offset(-5)
            make.bottom.equalTo(self.contentView.snp_bottom).offset(-5)
        }
        
        contrainView.backgroundColor = UIColor(hexString: "#f5fafb")
        
        lineNameLb.snp_makeConstraints(closure: {(make) in
            make.top.equalTo(contrainView.snp_top)
            make.left.equalTo(contrainView.snp_left).offset(5)
            make.right.equalTo(contrainView.snp_right).offset(-25)
            make.bottom.equalTo(self.lineInfoLb.snp_top)
            make.height.equalTo(self.lineInfoLb.snp_height)
        })
        lineNameLb.textAlignment = .Left
        lineNameLb.textColor = UIColor(hexString: "#5a5a5a")
        lineNameLb.font = UIFont.systemFontOfSize(13)
        
        
        lineInfoLb.snp_makeConstraints(closure: {(make) in
            
            make.top.equalTo(self.lineNameLb.snp_bottom)
            make.left.equalTo(contrainView.snp_left).offset(15)
            make.right.equalTo(contrainView.snp_right).offset(-25)
            make.bottom.equalTo(contrainView.snp_bottom).offset(2)
            make.height.equalTo(self.lineNameLb.snp_height)
        })
        lineInfoLb.textAlignment = .Left
        lineInfoLb.textColor = UIColor(hexString: "#4d757c")
        
        lineInfoLb.font = UIFont.systemFontOfSize(12)
        
        arrowImg.snp_makeConstraints(closure: {(make) in
            
            make.centerY.equalTo(contrainView.snp_centerY)
            make.width.equalTo(10)
            make.height.equalTo(5)
            make.right.equalTo(contrainView.snp_right).offset(-10)
            
        })
        arrowImg.image = UIImage(named: "下拉")
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // 旋转标识图片
    private func rotateIndicate() {
        UIView.animateWithDuration(0.3) { [weak self] in
            
            if self!.isOpen {
                self?.arrowImg.transform = CGAffineTransformMakeRotation(CGFloat(M_PI));
                
            }else{
                self?.arrowImg.transform = CGAffineTransformMakeRotation    (0);
            }
            
        }
    }

}
