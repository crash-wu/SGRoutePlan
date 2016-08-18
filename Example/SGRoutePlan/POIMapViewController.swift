//
//  POIMapViewController.swift
//  SGRoutePlan
//
//  Created by 吴小星 on 16/8/18.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import ArcGIS
import SGRoutePlan

class POIMapViewController: UIViewController {
    
    var mapView :AGSMapView!
    var searchBtn: UIButton!
    var poiKey = TdtPOISearchKeyword()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.mapView = AGSMapView(frame: self.view.frame)
        self.view.addSubview(self.mapView)
        
        self.searchBtn = UIButton(type: .Custom)
        self.view.insertSubview(self.searchBtn, aboveSubview: self.mapView)
        self.searchBtn.frame = CGRectMake(0, 0, 100, 40)
        self.searchBtn.setTitle("搜索银行", forState: .Normal)
        self.searchBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.searchBtn.backgroundColor = UIColor.blueColor()
        self.searchBtn.addTarget(self, action: #selector(POIMapViewController.search(_:)), forControlEvents: .TouchUpInside)
        
        self.edgesForExtendedLayout = .None
        self.automaticallyAdjustsScrollViewInsets = false
        
        //.********  加载地图 *********/
        AGSMapUtils.sharedInstance.loadTdtTileLayer(WMTS_VECTOR_2000, view: self.mapView)
        self.mapView.zoomToGuangZhouEnvelopeOnCGCS2000()
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc private func search(button:UIButton){
        
        poiKey.queryType = .POI
        poiKey.count = 20
        poiKey.keyWord = "银行"
        poiKey.start = 0
        poiKey.mapBound = SGRouteUtils.sharedInstance.getMapBound(self.mapView)
        poiKey.level = 14
        
        SGRoutePlanService.sharedInstance.poiSearch(poiKey, success: { (poi) in
            
                print("pois:\(poi)")
            
            }) { (error) in
                
                print("error:\(error)")
        }
        
    }

}
