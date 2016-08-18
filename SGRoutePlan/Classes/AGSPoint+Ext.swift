//
//  AGSPoint+Ext.swift
//  Pods
//
//  Created by 吴小星 on 16/8/18.
//
//

import Foundation
import ArcGIS

extension AGSPoint {
    /**
     转换坐标点的空间参考坐标系
     
     - parameter wkid: 坐标系ID
     
     常用坐标系：
     WGS84: 4326
     
     - returns: 转换后的坐标点
     */
    func projectToSpatialReferenceWithWKID(WKID: UInt) -> AGSPoint? {
        let src = AGSSpatialReference(WKID: WKID)
        return projectToSpatialReference(src)
    }
    
    
    func projectToSpatialReference(sr: AGSSpatialReference) -> AGSPoint? {
        let geoEng = AGSGeometryEngine.defaultGeometryEngine()
        return geoEng.projectGeometry(self, toSpatialReference: sr) as? AGSPoint
    }
    
    // 将坐标点投影到WebMercator坐标系 102100
    func projectToWebMercator() -> AGSPoint? {
        return projectToSpatialReference(AGSSpatialReference.webMercatorSpatialReference())
    }
    
    class func fromJSONString(jsonString str: String) -> AGSPoint? {
        guard let json = str.SGtoJSONObject() as? [NSObject: AnyObject] else {
            return nil
        }
        
        return AGSPoint(JSON: json)
    }
    
    /**
     国标2000坐标系转web墨卡托坐标
     
     :param: point 国标2000
     
     :returns: 返回web墨卡托坐标
     */
   public func ws84PointToWebPoint() ->AGSPoint?{
        let src = AGSSpatialReference(WKID: 102100)
        let geoEng = AGSGeometryEngine.defaultGeometryEngine()
        
        let webPoint = geoEng.projectGeometry(self, toSpatialReference: src) as? AGSPoint
        
        return webPoint
        
    }
    
    /**
     web墨卡托坐标转国标2000
     
     :param: point web墨卡托坐标
     
     :returns: 国标2000坐标
     */
    public  func webpointToWS84point() ->AGSPoint?{
        
        let src = AGSSpatialReference(WKID: 4490)
        let geoEng = AGSGeometryEngine.defaultGeometryEngine()
        
        let ws84point = geoEng.projectGeometry(self, toSpatialReference: src) as? AGSPoint
        
        return ws84point
        
    }
    
}
