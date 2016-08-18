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
            print("urlString:\(urlString)")
            
            
            var url = NSURL()
            
            if  let urlTemp  = NSURL(string:urlString){
                
                url = urlTemp
            }

            
            NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {[weak self] (data, response, error) in
                
                self?.responseDataProcess(data, response: response, error: error, success: { (json) in
                    guard let strongSelf = self else{return }
                    
                        if   let pois = Mapper<TdtPOIResult>().mapArray(json){
                            success(pois)
                            
                        }else{
                            fail(nil)
                        }                    
                    }, fail: { (error) in
                        
                        fail(error)
                })
                
            }).resume()
            
        }else{
           
            let errorNull = NSError.init(domain: SouthgisErrorDomain, code: SouthgisErrorCode.ServerErrorInvalidServiceType.rawValue, userInfo: ["message" : "无效服务"])
            fail(errorNull)
        }
    
    }
    
    
    private func responseDataProcess(data: NSData?, response :NSURLResponse?, error :NSError? ,success :([NSObject :AnyObject])->Void,fail:(NSError?)->Void){
        
        if (error != nil) {
            fail(error)
            
            return
        }
        
        if data == nil || data?.length == 0 {
            
            let errorNull = NSError.init(domain: SouthgisErrorDomain, code: SouthgisErrorCode.ServerErrorNullResponse.rawValue, userInfo: ["message" : "空数据"])
            return
        }
        
        var json = [NSObject :AnyObject]()

        
        if let dataTemp = data{
            if dataTemp is NSData{
                do{
                    if let  jsonTemp = try NSJSONSerialization.JSONObjectWithData(dataTemp, options: .MutableLeaves) as? [NSObject : AnyObject]{
                        json = jsonTemp
                        
                        success(json)
                        
                        return
                    }
                }catch{
                    
                }
            }
        }
        
        fail(NSError.init(domain: SouthgisErrorDomain, code: SouthgisErrorCode.ServerErrorNullResponse.rawValue, userInfo: ["message" : "空数据"]))
        
        return
        
    }

}
