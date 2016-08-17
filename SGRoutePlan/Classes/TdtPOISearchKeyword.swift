
//
//  TdtPOISearchKeyword.swift
//  Pods
//
//  Created by 吴小星 on 16/8/17.
//
//

import UIKit
import ObjectMapper


/**
 *  @author crash         crash_wu@163.com   , 16-08-17 10:08:59
 *
 *  @brief  天地图POI搜索实体
 */
public class TdtPOISearchKeyword: NSObject ,Mappable{

    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 10:08:23
     *
     *  @brief 返回的结果数量(用于分页和缓存)
     */
    public var count    :Int?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 10:08:35
     *
     *  @brief  返回结果起始位(用于分页 和缓存)默认 0
     */
    public var start        :Int?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 10:08:33
     *
     *  @brief  搜索的关键字(内容)
     */
    public var keyWord      :String?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 10:08:55
     *
     *  @brief  搜索类型
     */
    public var queryType    :QueryType? = .GeneralType
    
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 10:08:18
     *
     *  @brief  查询的地图范围("-x,-y,x,y")
     */
    public var mapBound     :String?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 10:08:26
     *
     *  @brief  目前查询的级别
     */
    public var level        :Int?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 10:08:38
     *
     *  @brief  查询半径(周边搜索时)
     */
    public var queryRadius  :Int?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 10:08:26
     *
     *  @brief  点坐标(周边搜索)
     */
    public var pointLonlat  :String?
    
    /**
     初始化函数
     */
    override init() {
        super.init()
        self.count = 10
        self.start = 0
        self.level = 10
        self.queryType = .GeneralType
    }
    
    required  convenience public init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        self.count          <- map["count"]
        self.start          <- map["start"]
        self.keyWord        <- map["keyWord"]
        self.mapBound       <- map["mapBound"]
        self.level          <- map["level"]
        self.queryType      <- map["queryRadius"]
        self.pointLonlat    <- map["pointLonlat"]
        self.queryRadius    <- map["queryRadius"]
    }

}
