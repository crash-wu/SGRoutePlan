//
//  Enum.swift
//  Pods
//
//  Created by 吴小星 on 16/8/17.
//
//

import Foundation

//MARK: 天地图POI搜索类型
/**
 天地图POI搜索类型
 
 -  GeneralType:                普通搜索(一般使用该类型)
 -  KenType:                    视野内搜索
 -  SurroundingType:            周边搜索
 -  SuggestType:                普通建议词搜索
 -  BusStationSuggestWordType:  公交规划起止点搜索提示词搜索
 -  BusStationType:             公交规划起止点搜索
 -  POI:                        纯 POI 搜索(不搜公交线)
 */
public enum QueryType :Int{
    /// 普通搜索
    case  GeneralType                 = 1
    /// 视野内搜索
     case  KenType                     = 2
    /// 周边搜索
     case  SurroundingType             = 3
    /// 普通建议词搜索
     case  SuggestType                 = 4
    ///公交规划起止点搜索提示词搜索
     case  BusStationSuggestWordType   = 5
    ///公交规划起止点搜索
     case  BusStationType              = 6
    /// 纯 POI 搜索(不搜公交线)
     case  POI                         = 7
    
    
        /// 类型描述
    public var describe :String{
        switch self {
        case .GeneralType:                  return "普通搜索"
        case .KenType:                      return "视野内搜索"
        case .SurroundingType:              return "周边搜索"
        case .SuggestType:                  return "普通建议词搜索"
        case .BusStationSuggestWordType:    return " 公交规划起止点搜索提示词搜索"
        case .BusStationType:               return "公交规划起止点搜索"
        case .POI:                          return "纯 POI 搜索(不搜公交线)"
        }
    }
}


//MARK: 公交路线类型
/**
 公交路线类型
 
 -  WallType:                步行
 -  BusType:                 公交
 -  MetroType:               地铁
 -  ChangeInMetroType:       地铁内换剩

 */
public enum BusRouteType :Int{
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 11:08:55
     *
     *  @brief  步行
     */
    case WallType           = 1
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 11:08:07
     *
     *  @brief  公交
     */
    case BusType            = 2
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 11:08:17
     *
     *  @brief  地铁
     */
    case MetroType          = 3
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 11:08:27
     *
     *  @brief  地铁内换剩
     */
    case ChangeInMetroType  = 4
}


//MARK: 公交规划搜索类型
/**
 公交规划搜索类型
 
 -  SpeedyType:                较快捷
 -  LessChangeType:            少换剩
 -  LessWalkType:              少步行
 -  NoMetroType:               不坐地铁
 
 */
public enum BusLineSearchType :Int {

    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 14:08:36
     *
     *  @brief  较快捷
     */
     case  SpeedyType = 1
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 14:08:49
     *
     *  @brief  少换剩
     */
     case  LessChangeType = 2
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 14:08:55
     *
     *  @brief  少步行
     */
     case  LessWalkType = 3
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 14:08:08
     *
     *  @brief  不坐地铁
     */
     case  NoMetroType = 4
}


//MARK: 搜索接口类型
/**
 搜索接口类型
 
 -  Query:                POI搜索
 -  Search:               驾车规划
 -  Busline:              公交换乘搜索
 -  Geocode:              逆地址编码查询
 
 */
public enum SGRoutePlanServiceType :String {
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 15:08:16
     *
     *  @brief  POI搜索
     */
     case Query
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 15:08:26
     *
     *  @brief  驾车规划
     */
     case Search
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 15:08:35
     *
     *  @brief  公交换乘搜索
     */
     case Busline
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-17 15:08:46
     *
     *  @brief  逆地址编码查询
     */
     case Geocode
    
    public var describe :String{
        
        switch self {
            case .Query:    return "query"
            case .Search:   return "search"
            case .Busline:  return "busline"
            case .Geocode:  return "geocode"
        }
    }
}

/**
 *  @author crash         crash_wu@163.com   , 16-08-17 16:08:06
 *
 *  @brief  错误标准
 */
public enum SouthgisErrorCode  :Int{
   case   ServerErrorInvalidServiceType   = 8001  // 无效的服务类型
   case   ServerErrorNullResponse         = 8002 // 空响应报文
   case   ServerErrorInvalidResponseData  = 8003  // 无效的响应数据
}

//MARK: 驾车路线规划类型
/**
 驾车路线规划类型
 
 -  FastType:                       最快路线
 -  ShortType:                      最短路线
 -  AvoidHightRoutType:             避开高速
 -  WalkType:                       步行
 
 */
public enum DriveLineType :Int {

    /**
     *  @author crash         crash_wu@163.com   , 16-08-19 16:08:37
     *
     *  @brief  最快路线
     */
    case FastType = 1
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-19 16:08:49
     *
     *  @brief  最短路线
     */
    case ShortType = 2
    
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-19 16:08:54
     *
     *  @brief  避开高速
     */
    case AvoidHightRoutType = 3
    
    /**
     *  @author crash         crash_wu@163.com   , 16-08-19 16:08:03
     *
     *  @brief  步行
     */
    case WalkType = 4
}