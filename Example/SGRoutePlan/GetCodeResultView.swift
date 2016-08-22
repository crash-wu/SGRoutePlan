//
//  GetCodeResultView.swift
//  SGRoutePlan
//
//  Created by 吴小星 on 16/8/22.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

class GetCodeResultView: UIView {

    var nameLb :UILabel!
    var addressLb :UILabel!
    
    convenience init(){
        self.init(frame: CGRectZero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        nameLb = UILabel()
        self.addSubview(nameLb)
        
        addressLb = UILabel()
        self.addSubview(addressLb)
        
        nameLb.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(5)
            make.top.equalTo(self.snp_top)
            make.bottom.equalTo(addressLb.snp_top)
            make.right.equalTo(self.snp_right).offset(5)
            make.height.equalTo(addressLb.snp_height)
        }
        nameLb.textColor = UIColor.blackColor()
        nameLb.textAlignment = .Left

        
        addressLb.snp_makeConstraints { (make) in
            make.top.equalTo(nameLb.snp_bottom)
            make.bottom.equalTo(self.snp_bottom)
            make.left.equalTo(self.snp_left).offset(5)
            make.right.equalTo(self.snp_right).offset(-5)
        }
        
        addressLb.textAlignment = .Left
        addressLb.textColor = UIColor.blackColor()

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
