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
