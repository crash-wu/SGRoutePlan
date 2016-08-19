//
//  SGRouteUtils.swift
//  Pods
//
//  Created by 吴小星 on 16/8/18.
//
//

import UIKit
import ArcGIS

/**
 *  @author crash         crash_wu@163.com   , 16-08-18 10:08:08
 *
 *  @brief  工具类
 */
public class SGRouteUtils: NSObject{

    //单列
    public static let sharedInstance = SGRouteUtils()
    
    //MARK: 清除poi搜索结果图层
    /**
     清除天地图poi搜索结果展示图层
     
     :param: mapView 当前地图
     */
   public func clearPOIResultLayer(mapView: AGSMapView){
        
        mapView.removeMapLayerWithName(SGRouteStruct.POI_POPO_LAYER_NAME)
        
    }
    
    
    //MARK: 移除驾车路线图层或者公交路线图层
    /**
     移除驾车路线图层或者公交路线图层
     
     :param: mapView 地图
     */
   public func clearLineLayer(mapView:AGSMapView){
        //移除驾车路线
        mapView.removeMapLayerWithName(SGRouteStruct.CAR_LINE_LAYER_NAME)
        mapView.removeMapLayerWithName(SGRouteStruct.CAR_LINE_DESTION_LAYER_NAME)
        mapView.removeMapLayerWithName(SGRouteStruct.CAR_LINE_ORIGIN_LAYER_NAME)
        
    }
    
    /**
     清除天地图POI搜索结果高亮显示图层
     
     :param: mapView 当前地图
     */
   public func clearHighlightLayer(mapView: AGSMapView){
        
        mapView.removeMapLayerWithName(SGRouteStruct.POI_POPO_SELECT_LAYER_NAME)
    }
    
    

    /**
     获取当前地图范围
     
     :param: mapView 地图
     
     :returns: 返回地图的左上角坐标，与右下角坐标(xmin,ymin,xmax,ymax)
     */
   public  func getMapBound(mapView:AGSMapView) ->String?{
        
        let envelope = mapView.visibleAreaEnvelope
    
        var mapBound :String = ""

    
        if mapView.spatialReference.isAnyWebMercator(){
            //web
            var  minPoint = AGSPoint(x: envelope.xmin, y: envelope.ymin, spatialReference: AGSSpatialReference.webMercatorSpatialReference())
            
            if let min = minPoint.webpointToWS84point(){
                minPoint = min
            }

            
            var maxPoint = AGSPoint(x: envelope.xmax, y: envelope.ymax, spatialReference: AGSSpatialReference.webMercatorSpatialReference())
            
            if let max = maxPoint.webpointToWS84point(){
                maxPoint = max
            }
            
            mapBound = String(minPoint.x) +  "," + String(minPoint.y) + "," + String(maxPoint.x) + "," + String(maxPoint.y)
            
        }else{
            //经纬度坐标
            mapBound = String(envelope.xmin) +  "," + String(envelope.ymin) + "," + String(envelope.xmax) + "," + String(envelope.ymax)
        }
        
        return mapBound
    }
    


    
    /**
     将POI搜索经纬度坐标转化成web坐标系
     
     :param: arry POI数据数组
     
     :returns: 坐标系转换后的POI数据
     */
    public func transferPoiResultToWebSpatialReference(arry :[TdtPOIResult]) -> [TdtPOIResult]?{
        
        var result :[TdtPOIResult] = []
        
        //遍历数组
        for value in arry {
            
            if let lonlatTemp = value.lonlat{
                
                let  lonlat = lonlatTemp.componentsSeparatedByString(" ")
                
                var point = AGSPoint(x:Double(lonlat[0])! , y: Double(lonlat[1])!, spatialReference: AGSSpatialReference.wgs84SpatialReference())
                
                if let webPoint = point.ws84PointToWebPoint(){
                        point = webPoint
                }
                
                value.lonlat = String(point.x) + " " + String(point.y)
                result.append(value)
            }

        }
        
        return result
        
    }
    
    
    
    
    //MARK: 获取天地图POI搜索结果坐标数组
    /**
     获取天地图POI搜索结果坐标数组
     
     :param: results    POI搜索数据
     
     :param: mapView 当前地图
     
     :returns: POI坐标数组
     */
   public func getPOIPoints(results:[TdtPOIResult]?,mapView:AGSMapView?) ->[AGSPoint]?{
        
        var array = [AGSPoint]()
        
        if let pois = results{
            
            for model in pois{
                if let lonlat = model.lonlat{
                    var points = lonlat.componentsSeparatedByString(" ")
                    
                    let  point = AGSPoint(x: Double(points[0])!, y: Double(points[1])!, spatialReference: mapView!.spatialReference)
                    array.append(point)
                }
            }
        }

        return array
    }
    
    
    
    //MARK: 在地图页面上，以大头针形式展示天地图POI搜索数据
    /**
     在地图页面上，以大头针形式展示天地图POI搜索数据
     
     :param: array POI搜索结果数组
     
     :param: mapView  当前地图
     
     :param: pinImageName 大头针图标名称
     */
   public func showPOIResultsLayer(
            array :[TdtPOIResult],
            mapView:AGSMapView,
            pinImageName:String){
        
        //先清除图层
        mapView.removeMapLayerWithName(SGRouteStruct.POI_POPO_LAYER_NAME)
        for model in array{
            
           let  symbolLayer = addPinToMapView(model, mapView: mapView, popoImageName: pinImageName)
            mapView.addMapLayer(symbolLayer, withName: SGRouteStruct.POI_POPO_LAYER_NAME)
        }
    }
    
    /**
     高亮显示天地图POI搜索结果
     
     :param: model   天地图POI搜索数据
     
     :param: mapView 地图
     
     :param: popoImageName 显示图标名称
     
     :returns: 返回显示状态
     */
   public func showHighlightLayer(
        model:TdtPOIResult,
        mapView:AGSMapView,
        pinImageName: String){
        
        //先清除图层
        mapView.removeMapLayerWithName(SGRouteStruct.POI_POPO_SELECT_LAYER_NAME)
        let  symbolLayer = addPinToMapView(model, mapView: mapView, popoImageName: pinImageName)
        mapView.addMapLayer(symbolLayer, withName: SGRouteStruct.POI_POPO_SELECT_LAYER_NAME)
    }
    
    /**
     添加大头针到地图
     
     :param: model   天地图POI搜索结果实体
     
     :param: mapView 地图
     
     :param: popoImageName 大头针图标名称
     
     :returns: AGSGraphicsLayer 图层
     */
    private  func addPinToMapView(
        model:TdtPOIResult,
        mapView:AGSMapView,
        popoImageName: String)->AGSGraphicsLayer{
    
        let  symbolLayer = AGSGraphicsLayer()
        let  graphicSymbol = AGSPictureMarkerSymbol(imageNamed: popoImageName)
        
        var tempArry  = [String]()
        
        if let lonlat = model.lonlat{
            
            tempArry = lonlat.componentsSeparatedByString(" ")
        }
        
        
        let  point = AGSPoint(x: Double(tempArry[0])!, y: Double(tempArry[1])!, spatialReference: mapView.spatialReference)
        
        //大头针属性
        var attribute : [String :AnyObject] = [:]
        
        //判断地图的坐标系
        if mapView.spatialReference.isAnyWebMercator() {
            //墨卡托坐标
            if let  ws84Point = point.webpointToWS84point(){

                let ws84Lonlat = String(ws84Point.x) + "," + String(ws84Point.y)
                attribute[SGRouteStruct.POI_LONLAT] = ws84Lonlat
            }
            
        }else{
            //经纬度坐标
            let lonlat = String(tempArry[0]) + "," + String(tempArry[1])
            attribute[SGRouteStruct.POI_LONLAT] = lonlat
        }
        
        
        attribute[SGRouteStruct.CALLOUT_TYPE] = SGRouteStruct.POI_CALLOUT_LAYER_NAME
        
        //地址属性
        if let address = model.address{
            
            attribute[SGRouteStruct.POI_ADDRESS] = address
        }
        
        //名称属性
        if let name = model.name{
            
            attribute[SGRouteStruct.POI_NAME] = name
        }
        
        //联系电话属性
        if let phone = model.phone{
            
            attribute[SGRouteStruct.POI_PHONE] = phone
        }
        
        //
        let  graphic = AGSGraphic(geometry: point, symbol: graphicSymbol, attributes: attribute )
        symbolLayer.addGraphic(graphic)
        mapView.zoomToGeometry(point, withPadding: 0, animated: true)
        return symbolLayer
    }
    

    //MARK: 在地图上绘制线路
    /**
     根据经纬度坐标点数字，在地图上绘制驾车/公交路线图
     
     :param: pointArray 坐标点数组
     
     :param: color      路线颜色
     
     :param: mapView    地图
     
     :param: startImageName 驾车/公交起点图标名称
     
     :param: endImageName  驾车/公交终点图标名称
     */
    public func drawLineOnMapView(
        pointArray:[AGSPoint],
        color:UIColor,
        mapView:AGSMapView,
        startImageName :String,
        endImageName:String){
        
        // 绘制图层前，线移除相关的图层   
        mapView.removeMapLayerWithName(SGRouteStruct.CAR_LINE_LAYER_NAME)
        mapView.removeMapLayerWithName(SGRouteStruct.CAR_LINE_ORIGIN_LAYER_NAME)
        mapView.removeMapLayerWithName(SGRouteStruct.CAR_LINE_DESTION_LAYER_NAME)
        
        let symbolLayer :AGSGraphicsLayer = AGSGraphicsLayer()
        
        let poly = AGSMutablePolyline(spatialReference: mapView.spatialReference)
        poly.addPathToPolyline()
        
        for point in pointArray{
            
            poly.addPointToPath(point)
        }
        
        let outlineSymbol = AGSSimpleLineSymbol()
        outlineSymbol.color = color
        outlineSymbol.width = 5
        outlineSymbol.style = .InsideFrame
        
        let graphic = AGSGraphic(geometry: poly, symbol: outlineSymbol, attributes: nil)
        symbolLayer.addGraphic(graphic)
        symbolLayer.refresh()
        
        mapView.zoomToGeometry(poly, withPadding: 0, animated: true)
        mapView.addMapLayer(symbolLayer, withName: SGRouteStruct.CAR_LINE_LAYER_NAME)
        
        if pointArray.count > 0{
            //驾车路线起点
            showOriginOrDestionPointOnMapView(pointArray[0], mapView: mapView, iconName: startImageName,layerName: SGRouteStruct.CAR_LINE_ORIGIN_LAYER_NAME)
            
            if let last = pointArray.last{
                //驾车路线终点
                showOriginOrDestionPointOnMapView(last, mapView: mapView, iconName: endImageName,layerName: SGRouteStruct.CAR_LINE_DESTION_LAYER_NAME)
            }
        }
    }
    
    
    /**
     绘制公交路线图
     
     :param: busLine        公公交线路实体
     
     :param: mapView        地图
     
     :param: lineColor      线路颜色
     
     :param: startImageName 起点图标名称
     
     :param: endImageName   终点图标名称
     */
    public func drawBusLine(
        busLine: BusLine ,
        mapView: AGSMapView ,
        lineColor :UIColor ,
        startImageName :String ,
        endImageName:String){
        
        var lonlat = String()
        if  let  segments = busLine.segments{
            
            for segment in segments{
                
                if  let busSegmentLines = segment.segmentLine{
                    
                    for busSegmentLine in busSegmentLines{
                        
                        lonlat = lonlat + (busSegmentLine.linePoint ?? "")
                    }
                }
                
            }
        }
        //经纬度字符串转换成经纬度坐标数组
        if   let points =  tramfortLonlatSToPoints(lonlat, mapView: mapView){
            
            //绘制线路
            drawLineOnMapView(points, color: lineColor, mapView: mapView, startImageName: startImageName, endImageName: endImageName)
        }
        
    }
    
    /**
     将坐标字符串转换成坐标数组
     
     :param: lonlats 坐标字符串
     
     :param: mapView 当前地图
     
     :return: 返回坐标数组
     */
   public func tramfortLonlatSToPoints(lonlats:String,mapView:AGSMapView)->[AGSPoint]?{
        
        var   lonLatArray = lonlats.componentsSeparatedByString(";")
        
        //去除最后一个数据
        lonLatArray.removeAtIndex(lonLatArray.count - 1)
        
        var pointArray  = [AGSPoint]()
        
        for lonlat in lonLatArray{
            
            var temp = lonlat.componentsSeparatedByString(",")
            
            let  point = AGSPoint(x: Double(temp[0])!, y: Double(temp[1])!, spatialReference: mapView.spatialReference)
            
            //判断地图坐标系
            if mapView.spatialReference.isAnyWebMercator() {
                //web坐标系

                if  let webPoint = point.ws84PointToWebPoint(){
                    pointArray.append(webPoint)
                }
                
            }else{
                //经纬度坐标系
                pointArray.append(point)
            }
        }
        
        return pointArray
    }
    
    
    /**
     绘制驾车路线起点终点坐标样式
     
     :param: point    起点终点坐标名称
     
     :param: mapView  地图
     
     :param: iconName 起点终点图标
     */
    func showOriginOrDestionPointOnMapView(point:AGSPoint ,mapView:AGSMapView,iconName:String,layerName:String)->Void{
        
        let  symbolLayer = AGSGraphicsLayer()
        let  graphicSymbol = AGSPictureMarkerSymbol(imageNamed: iconName)
        let  attribut = ["type" : "originOrDestion"]
        let  graphic = AGSGraphic(geometry: point, symbol: graphicSymbol, attributes: attribut )
        symbolLayer.addGraphic(graphic)
        symbolLayer.refresh()
        mapView.addMapLayer(symbolLayer, withName: layerName)
    }
    
    /**
     将地图缩放到第10级
     
     :param: mapView 地图
     */
    public  func zoomTo10Level(mapView:AGSMapView){
        
        //判断图层坐标系
        if mapView.spatialReference.isAnyWebMercator(){
            //web墨卡托坐标
            mapView.zoomToScale(577791.7098721985, animated: true)
            
        }else{
            
            //经纬度坐标
            mapView.zoomToScale(577791.7098721985, animated: true)
            
        }
        
    }
    
}
