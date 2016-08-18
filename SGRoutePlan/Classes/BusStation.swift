//
//  BusStation.swift
//  Pods
//
//  Created by 吴小星 on 16/8/17.
//
//

import UIKit
import ObjectMapper

/**
 *  @author crash         crash_wu@163.com   , 16-08-17 11:08:17
 *
 *  @brief  公交站实体
 */
public class BusStation: NSObject ,Mappable{

    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 11:08:30
     *
     *  @brief  公交站坐标
     */
    public var lonlat :String?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 11:08:48
     *
     *  @brief  公交站名称
     */
    public var name   :String?
    
    public override init() {
        super.init()
    }
    
    required public convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        self.lonlat <- map["lonlat"]
        self.name   <- map["name"]
    }

}
