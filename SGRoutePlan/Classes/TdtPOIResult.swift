//
//  TdtPOIResult.swift
//  Pods
//
//  Created by 吴小星 on 16/8/17.
//
//

import UIKit
import ObjectMapper

/**
 *  @author crash         crash_wu@163.com   , 16-08-17 09:08:56
 *
 *  @brief  天地图POI搜索结果实体
 */
public class TdtPOIResult: NSObject ,Mappable {

    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 09:08:17
     *
     *  @brief  POI点名称
     */
    public var name :String?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 09:08:02
     *
     *  @brief  POI兴趣点电话号码
     */
    public var phone :String?
    
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 09:08:45
     *
     *  @brief  POI兴趣点地址
     */
    public var address :String?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 09:08:17
     *
     *  @brief  POI兴趣点经纬度
     */
    public var lonlat: String?
    
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 09:08:48
     *
     *  @brief  POI兴趣点距离(周边搜索时)
     */
    public var distance :String?
    
   public override init() {
        super.init()
    }
    
    required public convenience init?(_ map: Map) {
        self.init()
    }
    
    
    public func mapping(map: Map) {
        
        self.name       <- map["name"]
        self.phone      <- map["phone"]
        self.address    <- map["address"]
        self.lonlat     <- map["lonlat"]
        self.distance   <- map["distance"]
    }
    
}
