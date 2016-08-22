//
//  ReverseAddress.swift
//  Pods
//
//  Created by 吴小星 on 16/8/22.
//
//

import UIKit
import ObjectMapper

/**
 *  @author crash         crash_wu@163.com   , 16-08-22 11:08:01
 *
 *  @brief  逆地址搜索结果实体(依据经纬度坐标查找位置信息)
 */
public class ReverseAddress: NSObject ,Mappable{
    
    /// 详情的位置信息
  public  var addressComponent: AddressComponent?
    
      /// 位置经纬度坐标实体
  public  var location: Location?
    
      /// 位置信息
  public  var formatted_address: String?
    
    public override init() {
        super.init()
        
    }
    
    public convenience required init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        self.addressComponent   <- map["addressComponent"]
        self.location           <- map["location"]
        self.formatted_address  <- map["formatted_address"]
    }
}


/**
 *  @author crash         crash_wu@163.com   , 16-08-22 11:08:49
 *
 *  @brief  经纬度坐标实体
 */
public class Location: NSObject ,Mappable {
      /// 经度
    public  var lon:Double?
    
              /// 纬度
    public  var lat: Double?
    
    public override init() {
        super.init()
    }
    
    public convenience required init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        self.lon <- map["lon"]
        self.lat <- map["lat"]
    }
    
    
}


/**
 *  @author crash         crash_wu@163.com   , 16-08-22 11:08:04
 *
 *  @brief  完整的地址位置信息实体
 */
public class AddressComponent: NSObject ,Mappable{
    /**
     *  @author crash         crash_wu@163.com   , 16-08-22 14:08:19
     *
     *  @brief  名称
     */
    public    var poi:String?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-22 14:08:33
     *
     *  @brief  街道编号
     */
    public    var road_distance:NSNumber?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-22 14:08:51
     *
     *  @brief  名称编号
     */
    public    var poi_distance:NSNumber?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-22 14:08:06
     *
     *  @brief  地址编号
     */
    public    var address_distance:NSNumber?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-22 14:08:28
     *
     *  @brief  地址方位
     */
    public    var address_position: String?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-22 14:08:05
     *
     *  @brief  所属行政区(镇)
     */
    public    var address: String?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-22 14:08:51
     *
     *  @brief  道路名称
     */
    public    var road: String?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-22 14:08:10
     *
     *  @brief  方位
     */
    public    var poi_position: String?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-22 14:08:28
     *
     *  @brief  所属行政区(市，乡，县)
     */
    public    var city: String?
    
    
    public override init() {
        super.init()
    }
    
    public convenience  required init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        self.poi              <- map["poi"]
        self.road_distance    <- map["road_distance"]
        self.poi_distance     <- map["poi_distance"]
        self.address_distance <- map["address_distance"]
        self.address_position <- map["address_position"]
        self.address          <- map["address"]
        self.road             <- map["road"]
        self.poi_position     <- map["poi_position"]
        self.city             <- map["city"]
    }
}