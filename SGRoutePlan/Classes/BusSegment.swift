//
//  BusSegment.swift
//  Pods
//
//  Created by 吴小星 on 16/8/17.
//
//

import UIKit
import ObjectMapper

/**
 *  @author crash         crash_wu@163.com   , 16-08-17 11:08:46
 *
 *  @brief  单条公交结果中的各段线路信息
 */
public class BusSegment: NSObject ,Mappable{

    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 11:08:53
     *
     *  @brief  线路类型
     */
    public var segmentType :BusRouteType?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 11:08:05
     *
     *  @brief  起站点内容
     */
    public var stationStart :BusStation?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 11:08:16
     *
     *  @brief  终站点内容
     */
    public var stationEnd: BusStation?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 11:08:26
     *
     *  @brief  线路内容
     */
    public var segmentLine: [BusSegmentLine]?
    
    public override init() {
        super.init()
    }
    
    required public convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {

        self.segmentType        <- map["segmentType"]
        self.stationStart       <- map["stationStart"]
        self.stationEnd         <- map["stationEnd"]
        self.segmentLine        <- map["segmentLine"]
    }
}
