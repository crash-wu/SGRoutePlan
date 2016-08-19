//
//  BusLineResultView.swift
//  imapMobile
//
//  Created by 吴小星 on 16/7/22.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit
import SCMultipleTableView

/**
 *  @author crash         crash_wu@163.com   , 16-07-22 16:07:42
 *
 *  @brief  公交路线结果
 */
class BusLineResultView: UIView {

    var tableView                 :SCMultipleTableView!
    var mapView                   :AGSMapView!
    
    var view                    :UIView!
        
    convenience init(){
        self.init(frame :CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()

        
        tableView = SCMultipleTableView(frame: CGRectZero, style: .Plain)
        self.addSubview(tableView)
        
        mapView = AGSMapView()
        self.addSubview(mapView)
        
//        view = UIView()
//        self.insertSubview(view, aboveSubview: mapView)

        
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.snp_top).offset(0)
            make.left.equalTo(self.snp_left).offset(2)
            make.right.equalTo(self.snp_right).offset(-2)
            make.height.equalTo(mapView.snp_height)
        }

        mapView.snp_makeConstraints { (make) in
            
            make.top.equalTo(tableView.snp_bottom).offset(5)
            make.left.equalTo(self.snp_left).offset(2)
            make.right.equalTo(self.snp_right).offset(-2)
            make.bottom.equalTo(self.snp_bottom).offset(-3)
        }
        
//        view.snp_makeConstraints { (make) in
//            make.edges.equalTo(mapView.snp_edges)
//        }
//        
//        view.backgroundColor = UIColor.redColor()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
}
