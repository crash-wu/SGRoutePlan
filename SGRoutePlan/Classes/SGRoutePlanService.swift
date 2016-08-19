//
//  SGRoutePlanService.swift
//  Pods
//
//  Created by 吴小星 on 16/8/17.
//
//

import UIKit
import ObjectMapper

/// 错误标准
let SouthgisErrorDomain = "com.Southgis.TianDituFramework.Error"

/**
 *  @author crash         crash_wu@163.com   , 16-08-17 14:08:31
 *
 *  @brief  天地图路线规划，POI搜索,驾车路线搜索
 */
public class SGRoutePlanService: NSObject {
    
  let TIANDITU_SEARCH_URL :String = "http://map.tianditu.com/query.shtml" //天地图web 搜索服务接口
    

    
    /// 单例
    public static let sharedInstance = SGRoutePlanService()
    
    /**
     拼接请求URL
     
     :param: searchType 搜索类型
     
     :param: postStr    搜索内容
     
     :returns: 请求URL
     */
    private func getSearceURl(searchType:SGRoutePlanServiceType
                ,postStr:String) ->String{
        
        return TIANDITU_SEARCH_URL + "?type=\(searchType.describe)&postStr=\(postStr)"
    }
    
    /**
     天地图POI搜索
     
     :param: keyword POI搜索实体
     
     :param: success 搜索成功闭包
     
     :param: fail    搜索失败闭包
     */
   public func poiSearch(keyword : TdtPOISearchKeyword
            ,success:([TdtPOIResult])->Void
            ,fail:(NSError?)->Void){
        
        if let requestJson = Mapper().toJSONString(keyword){
            
            let urlString = getSearceURl(.Query, postStr: requestJson.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
            var url = NSURL()
            
            if  let urlTemp  = NSURL(string:urlString){
                
                url = urlTemp
            }

            NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {[weak self] (data, response, error) in
                
                self?.responseDataProcess(data, response: response, error: error, success: { (json) in

                    
                        if let poiJson = json["pois"]{
                            
                            if let pois = Mapper<TdtPOIResult>().mapArray(poiJson){
                                success(pois)
                                return
                            }
                        }
                        //如果没有数据,则返回失败标识
                        fail(nil)
                    
                    }, fail: { (error) in
                        
                        fail(error)
                })
                
            }).resume()
            
        }else{
           
            let errorNull = NSError.init(domain: SouthgisErrorDomain, code: SouthgisErrorCode.ServerErrorInvalidServiceType.rawValue, userInfo: ["message" : "无效服务"])
            fail(errorNull)
        }
    
    }
    
    
    //MARK: 公交查询
    /**
     公交规划查询
     
     :param: keyword 公交搜索实体
     
     :param: success 搜索成功返回闭包
     
     :param: fail    搜索失败返回闭包
     */
    public func busSearch(keyword :BusLineSearch ,success:[BusLine]->Void,fail:(NSError)?->Void){
        
        
        if let requestJson = Mapper().toJSONString(keyword){
            
            let urlString = getSearceURl(.Busline, postStr: requestJson.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
            var url = NSURL()
            
            if  let urlTemp  = NSURL(string:urlString){
                
                url = urlTemp
            }
            
            NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {[weak self] (data, response , error) in
                
                self?.responseDataProcess(data, response: response, error: error, success: { (json) in
                    
                        if let results = json["results"] as? [[NSObject: AnyObject]]  where results.count > 0{

                            
                            if let linesJson = results[0]["lines"] as?[[NSObject: AnyObject]]{

                                if let lines = Mapper<BusLine>().mapArray(
                                    linesJson){

                                    success(lines)
                                    return
                                }
                            }
                            
                        }
                    
                        fail(nil)
                    
                    
                    }, fail: { (errors) in
                        fail(errors)
                })
            }).resume()
            
        }else{
            
            let errorNull = NSError.init(domain: SouthgisErrorDomain, code: SouthgisErrorCode.ServerErrorInvalidServiceType.rawValue, userInfo: ["message" : "无效服务"])
            fail(errorNull)
        }
        
    }
    
    /**
     解析请求返回数据
     */
    private func responseDataProcess(data: NSData?, response :NSURLResponse?, error :NSError? ,success :([NSObject :AnyObject])->Void,fail:(NSError?)->Void){
        
        if (error != nil) {
            fail(error)
            
            return
        }
        
        if data == nil || data?.length == 0 {
            
            let errorNull = NSError.init(domain: SouthgisErrorDomain, code: SouthgisErrorCode.ServerErrorNullResponse.rawValue, userInfo: ["message" : "空数据"])
            fail(errorNull)
            return
        }
        
        var json = [NSObject :AnyObject]()

        
        if let dataTemp = data{

            do{
                if let  jsonTemp = try NSJSONSerialization.JSONObjectWithData(dataTemp, options: .MutableLeaves) as? [NSObject : AnyObject]{
                    json = jsonTemp
                    
                    success(json)
                    
                    return
                }
            }catch{
                fail(nil)
            }

        }
        
        fail(NSError.init(domain: SouthgisErrorDomain, code: SouthgisErrorCode.ServerErrorNullResponse.rawValue, userInfo: ["message" : "空数据"]))
        
        return
        
    }

}
