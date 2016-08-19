//
//  CarLineSearch.swift
//  Pods
//
//  Created by 吴小星 on 16/8/19.
//
//

import UIKit
import ObjectMapper

/**
 *  @author crash         crash_wu@163.com   , 16-08-19 16:08:27
 *
 *  @brief  驾车路线规划请求实体
 */
public class CarLineSearch: NSObject ,Mappable {
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-19 16:08:14
     *
     *  @brief  起点经纬度 例如( 113.134 ,23.44)
     */
    public var orig     :String?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-19 16:08:22
     *
     *  @brief  终点经纬度 例如(113.234 ,24.3444)
     */
    public var dest     :String?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-19 16:08:27
     *
     *  @brief  途径点经纬度和 类型集合
     */
    public var mid      :String?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-19 16:08:40
     *
     *  @brief  驾车路线规划类型
     */
    public var style    :DriveLineType?
    
    
    public override init() {
        super.init()
    }
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
   public func mapping(map: Map) {
    
        self.orig   <- map["orig"]
        self.dest   <- map["dest"]
        self.mid    <- map["mid"]
        self.style  <- map["style"]
    }

}
