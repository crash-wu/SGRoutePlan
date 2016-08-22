//
//  GetCodeSearchKeyword.swift
//  Pods
//
//  Created by 吴小星 on 16/8/22.
//
//

import UIKit
import ObjectMapper

/**
 *  @author crash         crash_wu@163.com   , 16-08-22 11:08:43
 *
 *  @brief  逆地址编码搜索请求实体
 */
public class ReverseAddressSearchKeyword: NSObject ,Mappable {
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-22 11:08:29
     *
     *  @brief  经度
     */
   public  var lon: Double?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-22 11:08:05
     *
     *  @brief  纬度
     */
   public  var lat: Double?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-22 11:08:25
     *
     *  @brief  搜索key
     */
           var appkey: String?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-22 11:08:39
     *
     *  @brief  逆地址编码(1)
     */
           var ver: Int?
    
   public override init() {
        super.init()
        self.ver = 1
        self.appkey = "8a7b9aac0db21f9dd995e61a14685f05"
    }
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        
        self.lat    <- map["lat"]
        self.lon    <- map["lon"]
        self.ver    <- map["ver"]
        self.appkey <- map["appkey"]
    }

}




