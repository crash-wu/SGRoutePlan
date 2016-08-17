//
//  BusSegmentLine.swift
//  Pods
//
//  Created by 吴小星 on 16/8/17.
//
//

import UIKit
import ObjectMapper

/**
 *  @author crash         crash_wu@163.com   , 16-08-17 11:08:30
 *
 *  @brief  公交线路段内容
 */
public class BusSegmentLine: NSObject ,Mappable {
    

    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 14:08:01
     *
     *  @brief  此段线路的线路名
     */
    public var lineName             :String?
    
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 14:08:13
     *
     *  @brief  此段线路的完整线路名
     */
    public var direction            :String?
    
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 14:08:25
     *
     *  @brief  此段线路的坐标
     */
    public var linePoint            :String?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 14:08:41
     *
     *  @brief  一条线路中每小段距离,如果此段是步行 且距离小于 20 米,不返回此线段
     */
    public var segmentDistance      :Int?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 14:08:59
     *
     *  @brief  /此段线路需要经过的站点数
     */
    public var segmentStationCount  :Int?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 14:08:12
     *
     *  @brief  此段线路需要的时间
     */
    public var segmentTime          :Int?
    
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        
        self.lineName               <- map["lineName"]
        self.direction              <- map["direction"]
        self.linePoint              <- map["linePoint"]
        self.segmentDistance        <- map["segmentDistance"]
        self.segmentStationCount    <- map["segmentStationCount"]
        self.segmentTime            <- map["segmentTime"]
    }

}
