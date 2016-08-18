//
//  MapUtils.swift
//  imapMobile
//
//  Created by 吴小星 on 16/5/24.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit
import SGRoutePlan
import SGRoutePlan

let USER_LOCTION_LAYER_NAME = "user_loction_layer_name"

extension AGSMapView {
    /**
     将地图缩放至中国地图范围
     */
    func zoomToChineseEnvelope() {
        self.zoomToEnvelopeOnWebMercator(xmin: 7800000.0, ymin: 44000.0, xmax: 15600000.0, ymax: 7500000.0)
    }
    
    /**
     将地图缩放至广州地图范围
     */
    func zoomToGuangZhouEnvelope() {
        self.zoomToEnvelopeOnWebMercator(xmin: 12600000.0, ymin: 2637200.0, xmax: 12623900.0, ymax: 2656200.0)
    }
    
    func zoomToGuangZhouEnvelopeOnCGCS2000() {
        self.zoomToEnvelopeOnCGCS2000(xmin: 113.0, ymin: 22.5, xmax: 114.0, ymax: 23.9)
    }
    
    /**
     将地图缩放至湖南省地图范围
     */
    func zoomToHuNanEnvelope() {
        self.zoomToEnvelopeOnWebMercator(xmin: 12320000.0, ymin: 3100000.0, xmax: 12808000.0, ymax: 3408000.0)
    }
    
    
    /**
     缩放到中国视图范围
     */
    func zoomToChineseEnvelopeCGCS2000(){
        
        zoomToEnvelopeOnCGCS2000(xmin: 80.76016586869, ymin: 8.37639403682149, xmax: 145.522396132932, ymax: 52.9004273434877)
    }
    
    func zoomToEnvelopeOnCGCS2000(xmin xmin: Double, ymin: Double, xmax: Double, ymax: Double) {
        let sr = AGSSpatialReference(WKID: 4490)
        self.zoomToEnvelope(xmin: xmin, ymin: ymin, xmax: xmax, ymax: ymax, spatialReference: sr)
    }
    
    func zoomToEnvelopeOnWebMercator(xmin xmin: Double, ymin: Double, xmax: Double, ymax: Double) {
        self.zoomToEnvelope(xmin: xmin, ymin: ymin, xmax: xmax, ymax: ymax, spatialReference: AGSSpatialReference.webMercatorSpatialReference())
    }
    
    func zoomToEnvelope(xmin xmin: Double, ymin: Double, xmax: Double, ymax: Double, spatialReference: AGSSpatialReference) {
        let envelope = AGSEnvelope(xmin: xmin, ymin: ymin, xmax: xmax, ymax: ymax, spatialReference: spatialReference)
        
        self.zoomToEnvelope(envelope, animated: true)
    }
}



/**
 *  @author crash         crash_wu@163.com   , 16-05-24 09:05:01
 *
 *  @brief  地图工具类
 */
class AGSMapUtils: NSObject,CLLocationManagerDelegate {
    var currentLocationPoint :AGSPoint? = AGSPoint()//当前定位坐标
   weak private var currentMapView :AGSMapView? //当前地图
   private var location : CLLocationManager!

    
    

    

    //=======================================//
    //          MARK: 单例模式                 //
    //=======================================//
    static let sharedInstance = AGSMapUtils()
    
    //.=======================================//
    //          MARK: 定位功能                 //
    //=======================================//
    private override init() {
        location = CLLocationManager()
    }

    
     func locationFun (mapView:AGSMapView?) -> Void {
        self.currentMapView = mapView

        if CLLocationManager.locationServicesEnabled() {
            
            
            location.delegate = self
            location.desiredAccuracy = kCLLocationAccuracyBest
            location.distanceFilter = 1000.0
            location.requestAlwaysAuthorization()
            location.startUpdatingLocation()
            
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        switch status {
        case .AuthorizedAlways:
            
            if location.respondsToSelector(#selector(CLLocationManager.requestAlwaysAuthorization)) {
                
                location.requestAlwaysAuthorization()
            }
            
            break
            
        default:
            break
        }
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        

        showCurrentLocation(currentMapView , location: locations.last!)
    }
    
    func showCurrentLocation(mapView: AGSMapView? , location: CLLocation) -> Void {
        
        
        currentLocationPoint = AGSPoint(x: location.coordinate.longitude, y: location.coordinate.latitude, spatialReference: AGSSpatialReference(WKID: 4326))
        
        if let isweb = mapView?.spatialReference.isAnyWebMercator(){
            
            if isweb {
                
                //经纬度坐标转墨卡托
                let mercator = currentLocationPoint!.ws84PointToWebPoint()
                
                let locationLayer = AGSMapUtils().insertSymbolWithLocation(mercator!, symbolImage: "user_position")
                mapView?.removeMapLayerWithName("user_position")
                mapView?.addMapLayer(locationLayer, withName: USER_LOCTION_LAYER_NAME)
                mapView?.zoomToScale(36111.98186701241, withCenterPoint: mercator, animated: true)
                
            }else{
                
                let locationLayer = AGSMapUtils().insertSymbolWithLocation(currentLocationPoint!, symbolImage: "user_position")
                mapView?.removeMapLayerWithName("user_position")
                mapView?.addMapLayer(locationLayer, withName: USER_LOCTION_LAYER_NAME)
                mapView?.zoomToScale(36111.98186701241, withCenterPoint: currentLocationPoint, animated: true)
                
            }
        }
    }
    
    /**
     给坐标点添加显示图形
     
     :param: point     坐标点
     :param: imageName 图形名称
     
     :returns:
     */
    func insertSymbolWithLocation(point : AGSPoint,symbolImage imageName :String)->AGSGraphicsLayer?{
        
        let symbolLayer = AGSGraphicsLayer()
        
        let graphicSymbol = AGSPictureMarkerSymbol(imageNamed: imageName)
        
        var attributes : [String :AnyObject] = [:]
        attributes["type"] = 1
        
        let graphic = AGSGraphic(geometry: point, symbol: graphicSymbol, attributes: attributes)
        
        symbolLayer.addGraphic(graphic)
        
        symbolLayer.refresh()
        
        return symbolLayer
        
    }
    
    /**
     批量给坐标点添加显示图形
     
     :param: points    坐标点数组
     :param: imageName 图形名称
     
     :returns:
     */
    func insertSymbolWithPoinsArray(points : [AGSPoint],symbolImage imageName :String)->AGSGraphicsLayer?{
        
        let symbolLayer = AGSGraphicsLayer()
        
        let graphicSymbol = AGSPictureMarkerSymbol(imageNamed: imageName)
        
        var attributes : [String :AnyObject] = [:]
        attributes["type"] = 1
        
        for point in points{
            
            let graphic = AGSGraphic(geometry: point, symbol: graphicSymbol, attributes: attributes)
            
            symbolLayer.addGraphic(graphic)
        }
    
        symbolLayer.refresh()
        
        return symbolLayer
        
    }
    
    /**
     依据坐标点数组在地图上绘制线条
     
     :param: mapview 地图
     :param: points  坐标点数组
     */
    func drawLinewithPoinsOnMapView(mapview:AGSMapView,points :[AGSPoint]){
        
        let symbolLayer = AGSGraphicsLayer()
        let poly = AGSMutablePolyline(spatialReference: mapview.spatialReference)
        
        poly.addPathToPolyline()
        
        for point in points{
            
            poly.addPointToPath(point)
        }
        
        
        let outlinesSymbol = AGSSimpleLineSymbol()
        outlinesSymbol.color = UIColor(red: 0/255, green: 1/255, blue: 1/255, alpha: 1.0)
        outlinesSymbol.width = 3
        outlinesSymbol.style = .InsideFrame
        
        let graphic = AGSGraphic(geometry: poly, symbol: outlinesSymbol, attributes: nil)
        
        symbolLayer.addGraphic(graphic)
        symbolLayer.refresh()
        mapview.zoomToGeometry(poly, withPadding: 0, animated: true)
        
        
    }


    //MARK: 获取当前定位坐标字符串
    /**
     获取当前定位坐标字符串
     
     :returns: 定位坐标字符串(130.000,28.000)
     */
    func getCurrentLonLat() ->String?{
        
        if let point = currentLocationPoint {
          
            return (String(point.x) + "," + String(point.y))
        }else{
            
            return nil
        }

    }
    
    
    
    /**
     加载天地图图层
     
     :param: tdtLayerType 图层类型
     :param: view 地图容器
     */
    func loadTdtTileLayer(tdtLayerType:WMTSLayerTypes ,view:AGSMapView) -> Void {
        
        view.removeMapLayerWithName("tiandity_layer")
        view.removeMapLayerWithName("tiandity_layer_annotation")
        do{
            
            let tileLayer = try SouthgisTdt_TileLayer(layerType: tdtLayerType)
            view.addMapLayer(tileLayer, withName: "tiandity_layer")
            
        }catch let error {
            print("创建切片图层有误： \(error)")
        }
        
        
        var annotation : WMTSLayerTypes!
        
        switch tdtLayerType {
        case WMTS_VECTOR_MERCATOR://天地图矢量墨卡托投影地图服务
            annotation=WMTS_VECTOR_ANNOTATION_CHINESE_MERCATOR /*!< 天地图矢量墨卡托中文标注 */
            break
            
        case WMTS_IMAGE_MERCATOR://天地图影像墨卡托投影地图服务
            annotation=WMTS_IMAGE_ANNOTATION_CHINESE_MERCATOR /*!< 天地图影像墨卡托投影中文标注 */
            break
            
        case WMTS_TERRAIN_MERCATOR://天地图地形墨卡托投影地图服务
            annotation=WMTS_TERRAIN_ANNOTATION_CHINESE_MERCATOR /*!< 天地图地形墨卡托投影中文标注 */
            break
            
        case WMTS_VECTOR_2000://天地图矢量国家2000坐标系地图服务
            
            annotation=WMTS_VECTOR_ANNOTATION_CHINESE_2000 /*!< 天地图矢量国家2000坐标系中文标注 */
            break
            
        case WMTS_IMAGE_2000://天地图影像国家2000坐标系地图服务
            
            annotation=WMTS_IMAGE_ANNOTATION_CHINESE_2000 /*!< 天地图影像国家2000坐标系中文标注 */
            break
            
        case WMTS_TERRAIN_2000:
            annotation=WMTS_TERRAIN_ANNOTATION_CHINESE_2000 /*!< 天地图地形国家2000坐标系中文标注 */
            break
        default:
            break
            
        }
        
        do{
            
            let annotationLayer = try SouthgisTdt_TileLayer(layerType: annotation)
            view.addMapLayer(annotationLayer, withName: "tiandity_layer_annotation")
            
        }catch let error {
            print("创建注记图层有误:\(error)")
        }
        
        //设置地图环绕
        view.enableWrapAround()
    }
    
    
    /**
     给标绘图层一个默认symbol，并把其转换成JSON
     
     :returns: json
     */
     func getCompositesymbolToJSON()->[NSObject : AnyObject]?{
        
        let lineSymbol = AGSSimpleLineSymbol()
        lineSymbol.color = UIColor.yellowColor()
        lineSymbol.width = 4
        
        let innerSymbol = AGSSimpleFillSymbol()
        innerSymbol.color = UIColor.redColor().colorWithAlphaComponent(0.40)
        innerSymbol.outline = nil
        
        
        //A composite symbol for geometries on the graphics layer
        let compositeSymbol = AGSCompositeSymbol()
        compositeSymbol.addSymbol(lineSymbol)
        compositeSymbol.addSymbol(innerSymbol)
        
        let json : [NSObject : AnyObject] = compositeSymbol.encodeToJSON()
        
        return json
    }

}
