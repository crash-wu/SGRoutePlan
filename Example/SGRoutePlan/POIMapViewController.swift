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
    var busBtn   : UIButton!
    var carBtn   :UIButton!
    
    var clearBtn : UIButton!
    //POI 搜索实体
    var poiKey = TdtPOISearchKeyword()
    
        /// 公交搜索实体
    var busKey = BusLineSearch()
    
        /// 驾车搜索实体
    var carKey = CarLineSearch()
    
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
        
        self.busBtn = UIButton(type: .Custom)
        self.view.insertSubview(self.busBtn, aboveSubview: self.mapView)
        self.busBtn.frame = CGRectMake(100, 0, 100, 40)
        self.busBtn.setTitle("公交搜索", forState: .Normal)
        self.busBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.busBtn.backgroundColor = UIColor.blueColor()
        self.busBtn.addTarget(self, action: #selector(POIMapViewController.busSearch(_:)), forControlEvents: .TouchUpInside)
        
        self.carBtn = UIButton(type: .Custom)
        self.view.insertSubview(self.carBtn, aboveSubview: self.mapView)
        self.carBtn.frame = CGRectMake(200, 0, 100, 40)
        self.carBtn.setTitle("驾车搜索", forState: .Normal)
        self.carBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.carBtn.backgroundColor = UIColor.blueColor()
        self.carBtn.addTarget(self, action: #selector(POIMapViewController.carSearch(_:)), forControlEvents: .TouchUpInside)
        
        self.clearBtn = UIButton(type: .Custom)
        self.view.insertSubview(self.clearBtn, aboveSubview: self.mapView)
        self.clearBtn.frame = CGRectMake(300, 0, 100, 40)
        self.clearBtn.setTitle("清除搜索", forState: .Normal)
        self.clearBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.clearBtn.backgroundColor = UIColor.blueColor()
        self.clearBtn.addTarget(self, action: #selector(POIMapViewController.clear(_:)), forControlEvents: .TouchUpInside)
        
        
        self.edgesForExtendedLayout = .None
        self.automaticallyAdjustsScrollViewInsets = false
        
        //.********  加载地图 *********/
        AGSMapUtils.sharedInstance.loadTdtTileLayer(WMTS_VECTOR_2000, view: self.mapView)
        self.mapView.zoomToGuangZhouEnvelopeOnCGCS2000()
        
        //113.3714941059775,23.06889937192582
        //113.3796739596069 ,23.10052194023985
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
    
    //MARK: POI搜索
    @objc private func search(button:UIButton){
        
        poiKey.queryType = .POI
        poiKey.count = 20
        poiKey.keyWord = "银行"
        poiKey.start = 0
        poiKey.mapBound = SGRouteUtils.sharedInstance.getMapBound(self.mapView)
        poiKey.level = 14
        
        SGRoutePlanService.sharedInstance.poiSearch(poiKey, success: {[weak self] (poi) in

                SGRouteUtils.sharedInstance.showPOIResultsLayer(poi, mapView: (self?.mapView)!, pinImageName: "list_numb_img")
            
            }) { (error) in
                
                print("error:\(error)")
        }
        
    }
    
    //公交搜索
    @objc private func busSearch(button:UIButton){

        
        busKey.startposition = "113.3714941059775,23.06889937192582"
        busKey.endposition = "113.3796739596069 ,23.10052194023985"
        
        busKey.linetype = .SpeedyType
        
        SGRoutePlanService.sharedInstance.busSearch(busKey, success: { [weak self](lines) in
            
            
            dispatch_async(dispatch_get_main_queue(), { 
                guard let strongSelf = self else {return}
                
                let vc = BusLineResultViewController( mapView: strongSelf.mapView)
                vc.renderLines(lines)
                
                self?.navigationController?.pushViewController(vc, animated: true)
            })

            
            }) { (_) in
                
        }
        
        
    }
    
    
    @objc private func carSearch(button:UIButton){
        
        carKey.orig = "113.3714941059775,23.06889937192582"
        carKey.dest = "113.3796739596069,23.10052194023985"
        carKey.style = .FastType
        SGRoutePlanService.sharedInstance.driveSearch(carKey, success: { (line) in
            
                
            }) { (_) in
                
        }
    }
    
    @objc private func clear(button:UIButton){
        
        SGRouteUtils.sharedInstance.clearPOIResultLayer(self.mapView)
    }

}
