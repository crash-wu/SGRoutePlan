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
import SVProgressHUD

class POIMapViewController: UIViewController {
    
    var mapView :AGSMapView!
    var searchBtn: UIButton!
    var busBtn   : UIButton!
    var carBtn   :UIButton!
    var getCode  :UIButton!
    
    var clearBtn : UIButton!
    //POI 搜索实体
    var poiKey = TdtPOISearchKeyword()
    
        /// 公交搜索实体
    var busKey = BusLineSearch()
    
        /// 驾车搜索实体
    var carKey = CarLineSearch()
    
        ///
    var codeResultView = GetCodeResultView()
    
    var codeKey = ReverseAddressSearchKeyword()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.mapView = AGSMapView(frame: self.view.frame)
        self.view.addSubview(self.mapView)
        
        self.searchBtn = UIButton(type: .Custom)
        self.view.insertSubview(self.searchBtn, aboveSubview: self.mapView)
        self.searchBtn.frame = CGRectMake(0, 0, 70, 40)
        self.searchBtn.setTitle("搜银行", forState: .Normal)
        self.searchBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.searchBtn.backgroundColor = UIColor.blueColor()
        self.searchBtn.addTarget(self, action: #selector(POIMapViewController.search(_:)), forControlEvents: .TouchUpInside)
        
        self.busBtn = UIButton(type: .Custom)
        self.view.insertSubview(self.busBtn, aboveSubview: self.mapView)
        self.busBtn.frame = CGRectMake(70, 0, 70, 40)
        self.busBtn.setTitle("公交", forState: .Normal)
        self.busBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.busBtn.backgroundColor = UIColor.blueColor()
        self.busBtn.addTarget(self, action: #selector(POIMapViewController.busSearch(_:)), forControlEvents: .TouchUpInside)
        
        self.carBtn = UIButton(type: .Custom)
        self.view.insertSubview(self.carBtn, aboveSubview: self.mapView)
        self.carBtn.frame = CGRectMake(140, 0, 70, 40)
        self.carBtn.setTitle("驾车", forState: .Normal)
        self.carBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.carBtn.backgroundColor = UIColor.blueColor()
        self.carBtn.addTarget(self, action: #selector(POIMapViewController.carSearch(_:)), forControlEvents: .TouchUpInside)
        
        self.getCode = UIButton(type: .Custom)
        self.view.insertSubview(self.getCode, aboveSubview: self.mapView)
        self.getCode.frame = CGRectMake(210, 0, 70, 40)
        self.getCode.setTitle("逆地址", forState: .Normal)
        self.getCode.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.getCode.backgroundColor = UIColor.blueColor()
        self.getCode.addTarget(self, action: #selector(POIMapViewController.getCode(_:)), forControlEvents: .TouchUpInside)
        
        self.clearBtn = UIButton(type: .Custom)
        self.view.insertSubview(self.clearBtn, aboveSubview: self.mapView)
        self.clearBtn.frame = CGRectMake(280, 0, 70, 40)
        self.clearBtn.setTitle("清除", forState: .Normal)
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

        codeResultView = GetCodeResultView()
        self.view.insertSubview(codeResultView, aboveSubview: self.mapView)
        codeResultView.snp_makeConstraints { (make) in
            make.left.equalTo(self.view.snp_left)
            make.right.equalTo(self.view.snp_right)
            make.bottom.equalTo(self.view.snp_bottom)
            make.height.equalTo(200)
        }
        codeResultView.hidden = true
        
        
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
        
        SVProgressHUD.showWithStatus("正在搜索...")
        poiKey.queryType = .POI
        poiKey.count = 20
        poiKey.keyWord = "银行"
        poiKey.start = 0
        poiKey.mapBound = SGRouteUtils.sharedInstance.getMapBound(self.mapView)
        poiKey.level = 14
        
        SGRoutePlanService.sharedInstance.poiSearch(poiKey, success: {[weak self] (poi) in
                SVProgressHUD.showSuccessWithStatus("搜索成功!")
                SGRouteUtils.sharedInstance.showPOIResultsLayer(poi, mapView: (self?.mapView)!, pinImageName: "list_numb_img")
            
            }) { (error) in
                SVProgressHUD.showErrorWithStatus("失败!")
                print("error:\(error)")
        }
        
    }
    
    //公交搜索
    @objc private func busSearch(button:UIButton){

        SVProgressHUD.showWithStatus("正在搜索...")
        busKey.startposition = "113.3714941059775,23.06889937192582"
        busKey.endposition = "113.3796739596069 ,23.10052194023985"
        
        busKey.linetype = .SpeedyType
        
        SGRoutePlanService.sharedInstance.busSearch(busKey, success: { [weak self](lines) in
            SVProgressHUD.showSuccessWithStatus("搜索成功!")
            
            dispatch_async(dispatch_get_main_queue(), { 
                guard let strongSelf = self else {return}
                
                let vc = BusLineResultViewController( mapView: strongSelf.mapView)
                vc.renderLines(lines)
                
                self?.navigationController?.pushViewController(vc, animated: true)
            })
                SVProgressHUD.showErrorWithStatus("失败!")
            
            }) { (_) in
                
        }
        
        
    }
    
    
    @objc private func carSearch(button:UIButton){
        
        SVProgressHUD.showWithStatus("正在搜索...")
        carKey.orig = "113.3714941059775,23.06889937192582"
        carKey.dest = "113.3796739596069,23.10052194023985"
        carKey.style = .FastType
        SGRoutePlanService.sharedInstance.driveSearch(carKey, success: {[weak self] (line) in
            SVProgressHUD.showSuccessWithStatus("搜索成功!")
                SGRouteUtils.sharedInstance.drawDriveLine(line, mapView: (self?.mapView)!, lineColor: UIColor.blueColor(), startImageName: "start_popo", endImageName: "end_popo")
                
            }) { (_) in
                SVProgressHUD.showErrorWithStatus("失败!")
        }
    }
    
    @objc private func clear(button:UIButton){
        
        SGRouteUtils.sharedInstance.clearPOIResultLayer(self.mapView)
        SGRouteUtils.sharedInstance.clearLineLayer(self.mapView)
        SGRouteUtils.sharedInstance.clearHighlightLayer(self.mapView)
    }
    
    @objc private func getCode(button:UIButton){
        
        self.mapView.touchDelegate = self
    }

}


//MARK: AGSMapViewTouchDelegate
extension POIMapViewController : AGSMapViewTouchDelegate {
    
    func mapView(mapView: AGSMapView!, didClickAtPoint screen: CGPoint, mapPoint mappoint: AGSPoint!, features: [NSObject : AnyObject]!){
        
        
        
        SGRouteUtils.sharedInstance.showPinLayerToLocation(mappoint, symbolImage: "list_numb_img", mapView: self.mapView)
        
        codeKey = ReverseAddressSearchKeyword()
        codeKey.lon = mappoint.x
        codeKey.lat = mappoint.y
            SVProgressHUD.showWithStatus("正在搜索...")
        
        SGRoutePlanService.sharedInstance.getCode(codeKey, success: {[weak self] (model) in

            
                dispatch_async(dispatch_get_main_queue(), { 
                    SVProgressHUD.showSuccessWithStatus("搜索成功!")
                    guard let strongSelf = self else{return }
                    strongSelf.codeResultView.hidden = false
                    strongSelf.codeResultView.nameLb.text = model.addressComponent?.poi
                    strongSelf.codeResultView.addressLb.text = model.formatted_address
                    
                })
            
            
            }) { (_) in
                SVProgressHUD.showErrorWithStatus("失败!")
                
        }
    }
}

