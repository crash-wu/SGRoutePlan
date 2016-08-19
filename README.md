# SGRoutePlan

[![CI Status](http://img.shields.io/travis/吴小星/SGRoutePlan.svg?style=flat)](https://travis-ci.org/吴小星/SGRoutePlan)
[![Version](https://img.shields.io/cocoapods/v/SGRoutePlan.svg?style=flat)](http://cocoapods.org/pods/SGRoutePlan)
[![License](https://img.shields.io/cocoapods/l/SGRoutePlan.svg?style=flat)](http://cocoapods.org/pods/SGRoutePlan)
[![Platform](https://img.shields.io/cocoapods/p/SGRoutePlan.svg?style=flat)](http://cocoapods.org/pods/SGRoutePlan)

## Describe
天地图POI搜索，公交路线搜索，驾车路线搜索,逆地址编码 等服务工具。集成了在地图上展示POI搜索结果(显示大头针)，展示公交规划路线，驾车规划路线等功能       

## Usage
### import SGRoutePlan
   import SGRoutePlan 到项目中，便可以使用该工具类

### SGRoutePlanService 
    //该类提供天地图POI搜索，公交路线搜索，驾车路线搜索逆地址编码搜索等功能
    
    /// 单例
    //你可以使用可以使用该类提供的单列对象引用太类 ,例如  SGRoutePlanService.sharedInstance
    public static let sharedInstance = SGRoutePlanService()

    /**
    天地图POI搜索

    :param: keyword POI搜索实体

    :param: success 搜索成功闭包

    :param: fail    搜索失败闭包
    */
    public func poiSearch(keyword : TdtPOISearchKeyword
    ,success:([TdtPOIResult])->Void
    ,fail:(NSError?)->Void)


    /**
    公交规划查询

    :param: keyword 公交搜索实体

    :param: success 搜索成功返回闭包

    :param: fail    搜索失败返回闭包
    */
    public func busSearch(keyword :BusLineSearch ,success:[BusLine]->Void,fail:(NSError)?->Void)

### SGRouteUtils
    该类提供在地图上展示POI搜索结果(大头针),公交路线，驾车路线等相关功能。
    
    用户可以通过该类的单列对象引用该类成员方法
    //单列    
    public static let sharedInstance = SGRouteUtils()

    /**
    清除天地图poi搜索结果展示图层

    :param: mapView 当前地图
    */
    public func clearPOIResultLayer(mapView: AGSMapView)
        
    /**
    移除驾车路线图层或者公交路线图层

    :param: mapView 地图
    */
    public func clearLineLayer(mapView:AGSMapView)

    /**
    清除天地图POI搜索结果高亮显示图层

    :param: mapView 当前地图
    */
    public func clearHighlightLayer(mapView: AGSMapView)

    /**
    获取当前地图范围

    :param: mapView 地图

    :returns: 返回地图的左上角坐标，与右下角坐标(xmin,ymin,xmax,ymax)
    */
    public  func getMapBound(mapView:AGSMapView) ->String?

    /**
    在地图页面上，以大头针形式展示天地图POI搜索数据

    :param: array POI搜索结果数组

    :param: mapView  当前地图

    :param: pinImageName 大头针图标名称
    */
    public func showPOIResultsLayer(
    array :[TdtPOIResult],
    mapView:AGSMapView,
    pinImageName:String)

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
    pinImageName: String)

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
    endImageName:String)
    
### BusLine
    天地图公交路线实体

### TdtPOIResult
    天地图POI搜索结果实体

### TdtPOISearchKeyword
    天地图POI搜索请求参数

### BusLineSearch
    天地图公交路线请求参数

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
    ArcGIS-Runtime-SDK-iOS for version 10.2.5

## Installation

SGRoutePlan is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SGRoutePlan"
```

## Author

吴小星, crash_wu@163.com


### Example 
#### 公交 搜索动图
    [!()](http://images.cnblogs.com/cnblogs_com/crash-wu/869862/o_公交.gif)

#### POI 搜索动图
    [!()](http://images.cnblogs.com/cnblogs_com/crash-wu/869862/o_POI.gif)

## License

SGRoutePlan is available under the MIT license. See the LICENSE file for more info.
