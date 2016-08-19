//
//  BusLineViewModel.swift
//  imapMobile
//
//  Created by 吴小星 on 16/5/31.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit
import Foundation
import SGRoutePlan

struct BusLineViewModel {
    
    static func heightForCell() -> CGFloat {
        return 50.0
    }
    
    static func heightForHeader() -> CGFloat {
        return 80.0
    }
    
    /**
     section 单元格数据填充
     
     :param: data    数据源
     :param: section section索引
     :param: view    section headView
     */
    static func viewForHeaderInSection(data:[BusLine]?,section:Int,view:BusLineSectionView?)->Void{
        
        guard data == nil else{
            
            let model = data![section]
            
            var  lineName :String = model.lineName ?? ""
            lineName.removeAtIndex(lineName.endIndex.predecessor())
            let name = lineName.stringByReplacingOccurrencesOfString("|", withString: "换乘")
            view?.lineNameLb?.text = name
            
            view?.lineInfoLb?.text = getLineInfo(model.segments!)

            
            return
        }
    }
    
    
    static func numberOfSectionsInSCMutlipleTableView(data:Array<BusLine>?)->Int{
        
        if data != nil {
            return data!.count
        }
        
        return 0
    }
    
    
    /**
     获取section单元格数量
     
     :param: data    数据源
     :param: section section索引
     
     :returns: section 中cell数量
     */
    static func numberOfRowsInSection(data:[BusLine]?,section:Int)->Int{

        if data != nil{
            
            if   let segmentArray = data![section].segments {
                return segmentArray.count
            }
            
        }
        return 0
        
    
    }
    
    /**
     cell 单元格数据填充
     
     :param: data      数据源
     :param: cell      需要填充数据的单元格
     :param: indexPath 单元格索引
     */
    static func cellForRowAtIndexPath(data:[BusLine]?,cell:BusLineCell,indexPath:NSIndexPath){
        
        guard data == nil else{
           
            if  let segmentArray = data![indexPath.section].segments{
                    setupBusLineCellData(segmentArray, cell: cell, indexPath: indexPath)
            }

            
            return
        }

    }
    
    //.=======================================//
    //          MARK: Private                //
    //=======================================//
   private static func setupBusLineCellData(segmentArray:[BusSegment],cell:BusLineCell,indexPath:NSIndexPath)->Void{
        
        let segment = segmentArray[indexPath.row]
        var stationEnd = BusStation()
    
        if let stationEndTemp = segment.stationEnd{
            stationEnd = stationEndTemp
        }

    
        let segmentLine = segment.segmentLine![0]
    
        if indexPath.row == segmentArray.count - 1 && segmentArray.count > 0{
            cell.line.hidden = false
        }else{
            cell.line.hidden = true
        }
    
        if let segmentType = segment.segmentType{
            switch segmentType {
            case .WallType://步行
                if indexPath.row == segmentArray.count - 1 {
                    
                    cell.actionLabel?.text = "步行 " + " " + "至 " + "终点"
                    cell.upLineView?.hidden = false
                    cell.downLineView?.hidden = true
                    
                }else{
                    
                    cell.actionLabel?.text = "步行 " + " " + "至 " + "\(stationEnd.name ?? "" )"
                    cell.downLineView?.hidden = false
                    cell.upLineView?.hidden = true
                }
                
                
                cell.distanceLabel?.text = "\(segmentLine.segmentDistance ?? 0) 米"
                cell.typeIcon?.image = UIImage(named: "路线规划-步行")
                
                break
            case .BusType:
                cell.actionLabel?.text = "乘坐 " + "\(segmentLine.lineName ?? "")" + " 至 " + "\(stationEnd.name ?? "")"
                cell.distanceLabel?.text = "\(segmentLine.segmentStationCount ?? 0) 站"
                cell.typeIcon?.image = UIImage(named: "路线规划-公交")
                
                break
                
                
            default:
                
                cell.actionLabel?.text = "乘坐 " + "\(segmentLine.lineName ?? "")" + " 至 " + "\(stationEnd.name ?? "")"
                cell.distanceLabel?.text = "\(segmentLine.segmentStationCount ?? 0) 站"
                cell.typeIcon?.image = UIImage(named: "路线规划-地铁")
                
                break
            }
        }

    
    
        if indexPath.row == segmentArray.count - 1 {

            cell.upLineView?.hidden = false
            cell.downLineView?.hidden = true
        
        }else if indexPath.row == 0{

            cell.downLineView?.hidden = false
            cell.upLineView?.hidden = true
        }else{
            
            cell.downLineView?.hidden = false
            cell.upLineView?.hidden = false
            
        }
    
    }
    
    
    /**
     获取公交路线信息详情
     
     :param: segmentsArray 公交数据
     
     :returns: 公交路线信息
     */
     static func getLineInfo(segmentsArray:[BusSegment])->String{
        //换乘数
        var changeTime = 0
        
        //用时
        var totalTime = 0
        
        //总距离
        var totalDistance :CGFloat = 0
        
        for segment in segmentsArray{
            
            if segment.segmentType != BusRouteType.WallType {
                
                changeTime = changeTime + 1
            }
            
            let segmentLine = segment.segmentLine![0]
            
            if let segmentTime = segmentLine.segmentTime{
                
                totalTime = totalTime + segmentTime

            }
            
            if let segmentDistance = segmentLine.segmentDistance{
                
                totalDistance = totalDistance + CGFloat(segmentDistance)
            }

        }

        var lineInfo = String()
        
        if (changeTime - 1 < 1){
            lineInfo = "直达 " + " " + "里程:\(totalDistance/1000)Km" + " " + "历时:\(totalTime)分"
            
        }else{
            
            lineInfo = "换乘:\(changeTime)" + " " + "里程:\(totalDistance/1000)Km" + " " + "历时:\(totalTime)分"
        }
        
        return lineInfo
    }
    
    /**
     获取公交路线坐标字符串
     
     :param: busLine 公交线路实体
     
     :returns: 坐标字符串
     */
    static func getLineLonlatString(busLine: BusLine)->String{
        
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
        return lonlat
    }

}
