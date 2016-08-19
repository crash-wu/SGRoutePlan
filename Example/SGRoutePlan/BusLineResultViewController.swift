//
//  BusLineResultViewController.swift
//  imapMobile
//
//  Created by 吴小星 on 16/7/22.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit
import SCMultipleTableView
import SGRoutePlan




class BusLineResultViewController: UIViewController {
    
    private var resultView   : BusLineResultView!

    private var busLineArray = [BusLine](){
        //公交路线规划结果数组
        didSet{
            headers = busLineArray.map({ (busLine) -> BusLineSectionView in
                let header = BusLineSectionView(reuseIdentifier: nil)
                
                var  lineName :String = busLine.lineName ?? ""
                lineName.removeAtIndex(lineName.endIndex.predecessor())
                let name = lineName.stringByReplacingOccurrencesOfString("|", withString: "换乘")
                header.lineNameLb?.text = name
                
                header.lineInfoLb?.text = BusLineViewModel.getLineInfo(busLine.segments!)
                return header
            })
        }
        
    }
    
    private var busLineSearch = BusLineSearch()
    private var headers = [BusLineSectionView]()


    /**
     初始化
     
     :param: busLineSearch  公交路线搜索实体
     
     :param: originAddress  起点地址
     
     :param: destionAddress 终点地址
     
     :param: busLineArray   公交路线结果
     */
    init(mapView: AGSMapView){
        super.init(nibName: nil, bundle: nil)
        self.edgesForExtendedLayout = .None
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        resultView = BusLineResultView()
        self.view.addSubview(resultView)
        
        resultView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view.snp_edges)
        }
        
        resultView.tableView.multipleDelegate = self
        resultView.tableView.tableView.registerClass(BusLineSectionView.self, forHeaderFooterViewReuseIdentifier: "buse_line_head_id")

//        resultView.mapView = mapView

        //.********  加载地图 *********/
        AGSMapUtils.sharedInstance.loadTdtTileLayer(WMTS_VECTOR_2000, view: resultView.mapView)
        resultView.mapView.zoomToGuangZhouEnvelopeOnCGCS2000()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultView.tableView.reload()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    /**
     渲染公交路线
     
     :param: busLineArray 公交路线数组
     */
    func renderLines(busLineArray:[BusLine]){
        
        self.busLineArray = busLineArray
    }
    

    
}

extension BusLineResultViewController : SCMultipleTableDelegate{
    
    
    func numberOfSectionsInSCMutlipleTableView(tableView: SCMultipleTableView) -> Int {
        
        return  BusLineViewModel.numberOfSectionsInSCMutlipleTableView(busLineArray)
    }
    
    func m_tableView(tableView: SCMultipleTableView, numberOfRowsInSection section: Int) -> Int {
        return BusLineViewModel.numberOfRowsInSection(busLineArray, section: section)
    }
    
    func m_tableView(tableView: SCMultipleTableView, viewForHeaderInSection section: Int) -> UIView? {
       
//        BusLineViewModel.viewForHeaderInSection(busLineArray, section: section, view: headView)
        
        let header = headers[section]
        return header

    }
    
    func m_tableView(tableView: SCMultipleTableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
    }
    
    func m_tableView(tableView: SCMultipleTableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func m_tableView(tableView: SCMultipleTableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell? {
        
        let cellID = "cellID"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as! BusLineCell!
        
        if cell == nil {
            cell = BusLineCell(style: .Default, reuseIdentifier: cellID)
        }
        
        BusLineViewModel.cellForRowAtIndexPath(busLineArray, cell: cell, indexPath: indexPath)
        

        return cell
    }
    
    // 点击头部即将打开列表
    func m_tableView(tableView: SCMultipleTableView, willOpenSubRowFromSection section: Int) {
        if let header = tableView.tableView.headerViewForSection(section) as? BusLineSectionView {
            header.isOpen = true
            header.layer.borderWidth = 1
            header.layer.borderColor = UIColor.grayColor().CGColor
        }

        
        SGRouteUtils.sharedInstance.drawBusLine(busLineArray[section], mapView: resultView.mapView, lineColor: UIColor.blueColor(), startImageName: "start_popo", endImageName: "end_popo")
        
    }
    
    // 点击头部即将关闭列表
    func m_tableView(tableView: SCMultipleTableView, willCloseSubRowFromSection section: Int) {
        if let header = tableView.tableView.headerViewForSection(section) as? BusLineSectionView {
            header.isOpen = false
            header.layer.borderWidth = 0
        }
        
        SGRouteUtils.sharedInstance.clearLineLayer(resultView.mapView)
    }
}


