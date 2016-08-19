//
//  CarLineNode.swift
//  Pods
//
//  Created by 吴小星 on 16/8/19.
//
//

import UIKit
import ObjectMapper

/**
 *  @author crash         crash_wu@163.com   , 16-08-19 16:08:04
 *
 *  @brief  驾车路线节点信息实体
 */
public class CarLineNode: NSObject ,Mappable{

    /**
     *  @author crash         crash_wu@163.com   , 16-08-19 16:08:23
     *
     *  @brief  每段线路文字描述
     */
    public var strguide         :String?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-19 16:08:34
     *
     *  @brief  当前路段名称
     */
    public var signage          :String?
    
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-19 16:08:53
     *
     *  @brief  “路牌”引导提示/高速路收费站出口信息
     */
    public var streetName       :String?
    
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-19 16:08:05
     *
     *  @brief  下一段道路名称
     */
    public var nextStreetName   :String?
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-19 16:08:18
     *
     *  @brief  道路收费信息(0=免费路段,1=收费路段,2=部分收费路 段)
     */
    public var tollStatus       :String?
    
    
    public override init() {
        super.init()
    }
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        
        self.strguide           <- map["strguide"]
        self.signage            <- map["signage"]
        self.streetName         <- map["streetName"]
        self.nextStreetName     <- map["nextStreetName"]
        self.tollStatus         <- map["tollStatus"]
    }

}
