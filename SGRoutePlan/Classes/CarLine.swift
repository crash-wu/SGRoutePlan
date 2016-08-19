//
//  CarLine.swift
//  Pods
//
//  Created by 吴小星 on 16/8/19.
//
//

import UIKit
import ObjectMapper

/**
 *  @author crash         crash_wu@163.com   , 16-08-19 16:08:39
 *
 *  @brief  驾车路线实体
 */

public class CarLine: NSObject ,Mappable{
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-19 16:08:42
     *
     *  @brief  驾车路线节点信息
     */
    public var carRoutes    :[CarLineNode]?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-19 16:08:08
     *
     *  @brief  驾车查询时，导航路线地图的信息
     */
    public var mapInfo      :CarMapInfoNode?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-19 16:08:17
     *
     *  @brief  距离
     */
    public var distance     :String?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-19 16:08:29
     *
     *  @brief  线路经纬度字符串
     */
    public var routelatlon  :String?
    
    
    public override init() {
        super.init()
    }
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        self.carRoutes      <- map["carRoutes"]
        self.mapInfo        <- map["mapInfo"]
        self.distance       <- map["distance"]
        self.routelatlon    <- map["routelatlon"]
    }
}
