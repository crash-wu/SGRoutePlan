//
//  RoutePlanViewController.swift
//  SGRoutePlan
//
//  Created by 吴小星 on 16/8/18.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class RoutePlanViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    var tableView :UITableView!
    var data = ["POI","公交","驾车"]
    
     init(){
        super.init(nibName: nil, bundle: nil)
        
        tableView = UITableView(frame: self.view.frame, style: .Plain)
        self.view.addSubview(tableView)
        tableView.separatorStyle = .None
        tableView.registerClass(UITableViewCell.self , forCellReuseIdentifier: "cellID")
        self.view.backgroundColor = UIColor.whiteColor()
        self.edgesForExtendedLayout = .None
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.data.count
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCellWithIdentifier("cellID", forIndexPath: indexPath)
        
        cell.textLabel?.text = self.data[indexPath.row]
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
        case 0: self.navigationController?.pushViewController(POIMapViewController(), animated: true)
            
        default: break
            
        }
    }

}
