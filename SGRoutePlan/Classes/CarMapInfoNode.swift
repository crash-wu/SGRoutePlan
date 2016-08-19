//
//  CarMapInfoNode.swift
//  Pods
//
//  Created by 吴小星 on 16/8/19.
//
//

import UIKit
import ObjectMapper

/**
 *  @author crash         crash_wu@163.com   , 16-08-19 16:08:48
 *
 *  @brief  驾车查询时，导航路线地图的信息
 */
public class CarMapInfoNode: NSObject ,Mappable{

    /**
     *  @author crash         crash_wu@163.com   , 16-08-19 16:08:23
     *
     *  @brief  全部结果同时显示的适宜中心经纬度
     */
    public var center  :String?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-19 16:08:32
     *
     *  @brief  全部结果同时显示的适宜缩放比例
     */
    public var scale   :String?
    
    
    public override init() {
        super.init()
    }
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        
        self.center <- map["center"]
        self.scale  <- map["scale"]
    }
}
