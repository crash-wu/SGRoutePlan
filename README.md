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

## License

SGRoutePlan is available under the MIT license. See the LICENSE file for more info.
