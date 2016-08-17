//
//  BusLineSearch.swift
//  Pods
//
//  Created by 吴小星 on 16/8/17.
//
//

import UIKit
import ObjectMapper

/**
 *  @author crash         crash_wu@163.com   , 16-08-17 14:08:55
 *
 *  @brief  公交路线请求参数实体
 */
public class BusLineSearch: NSObject ,Mappable{

    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 14:08:12
     *
     *  @brief  出发点坐标 “经度,纬度”
     */
    public var startposition :String?
    
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 14:08:23
     *
     *  @brief  终点坐标 “经度,纬度”
     */
    public var endposition   :String?
    
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 14:08:38
     *
     *  @brief  获取线路规划类型
     */
    public var linetype      :BusLineSearchType?
    
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        
        self.endposition    <- map["endposition"]
        self.startposition  <- map["startposition"]
        self.linetype       <- map["linetype"]
    }

}
