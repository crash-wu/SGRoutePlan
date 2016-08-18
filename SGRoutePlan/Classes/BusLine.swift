
//
//  BusLine.swift
//  Pods
//
//  Created by 吴小星 on 16/8/17.
//
//

import UIKit
import ObjectMapper

/**
 *  @author crash         crash_wu@163.com   , 16-08-17 11:08:47
 *
 *  @brief  公交线路
 */
public class BusLine: NSObject ,Mappable {
    

    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 11:08:38
     *
     *  @brief  单条公交结果线路名称,如:3 路—4 路—5 路
     */
    public var lineName: String?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 11:08:48
     *
     *  @brief  单条公交结果中的各段线路信息
     */
    public var segments: [BusSegment]?
    
    
   public  override init() {
        super.init()
    }
    
    required public convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        self.lineName   <- map["lineName"]
        self.segments   <- map["segments"]
    }

}
