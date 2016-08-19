//
//  SCMultipleTableView.swift
//  imapMobile
//
//  Created by 吴小星 on 16/5/13.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit

/**
 *  @author crash         crash_wu@163.com   , 16-05-13 15:05:12
 *
 *  @brief  两级列表协议
 */
@objc public protocol SCMultipleTableDelegate : NSObjectProtocol{
    
    
    /**
     计算每个section中单元格数量
     
     :param: tableView 目标tableView
     :param: section 目标section
     
     :returns: section中单元格数量
     */
    func m_tableView(tableView:SCMultipleTableView, numberOfRowsInSection section : Int) ->Int
    
    
    /**
     单元格布局
     
     :param: tableView 目标tableView
     :param: indexPath 单元格索引
     
     :returns: 单元格
     */
    func m_tableView(tableView:SCMultipleTableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell?
    
    
    
    
    /**
     计算tableView section数量
     
     :param: tableView 目标tablieView
     
     :returns: section 数量
     */
    optional func numberOfSectionsInSCMutlipleTableView(tableView:SCMultipleTableView) ->Int
    
    
    /**
     计算cell高度
     
     :param: tableView 目标tableView
     :param: indexPath cell 索引
     
     :returns: cell高度
     */
    optional func m_tableView(tableView :SCMultipleTableView , heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    
    
    /**
     section headView 高度
     
     :param: tableView 目标tableView
     :param: section 待计算的section
     
     :returns: section headView 高度
     */
    optional func m_tableView(tableView :SCMultipleTableView , heightForHeaderInSection section :Int) ->CGFloat
    
    
    
    /**
     section footView 高度
     
     :param: tableView 目标tableView
     :param: section   待计算的section
     
     :returns: section headView 高度
     */
    optional func m_tableView(tableView :SCMultipleTableView , heightForFootInSection section :Int) ->CGFloat
    
    
    
    /**
     section headView 样式
     
     :param: tableView 目标tableView
     :param: section
     
     :returns: section headView 样式
     */
    optional func m_tableView(tableView:SCMultipleTableView,viewForHeaderInSection section :Int) ->UIView?
    
    
    /**
     展开section 中的row 单元格
     
     :param: tableView
     :param: section 需要展开的section
     */
    optional func m_tableView(tableView:SCMultipleTableView , willOpenSubRowFromSection section :Int) ->Void
    
    
    /**
     收起section 中的row 单元格
     
     :param: tableView
     :param: section 需要收起的section
     
     :returns:
     */
    optional func m_tableView(tableView:SCMultipleTableView ,willCloseSubRowFromSection section :Int) ->Void
    
    
    /**
     选中单元格
     
     :param: tableView
     :param: indexPath 单元格索引
     
     :returns:
     */
    optional func m_tableView(tableView:SCMultipleTableView ,didSelectRowAtIndexPath indexPath :NSIndexPath) ->Void
    
    optional func  m_scrollViewDidScroll(scrollView: UIScrollView)
    
    
    optional  func m_scrollViewDidZoom(scrollView: UIScrollView) // any zoom scale changes
    
    // called on start of dragging (may require some time and or distance to move)
    optional  func m_scrollViewWillBeginDragging(scrollView: UIScrollView)
    // called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest

    optional  func m_scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    // called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
    optional  func m_scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool)
    

    optional  func m_scrollViewWillBeginDecelerating(scrollView: UIScrollView) // called on finger up as we are moving

    optional  func m_scrollViewDidEndDecelerating(scrollView: UIScrollView) // called when scroll view grinds to a halt
    

    optional  func m_scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) // called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
    
    optional  func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? // return a view that will be scaled. if delegate returns nil, nothing happens
    
    optional  func m_scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView?) // called before the scroll view begins zooming its content
    

    optional  func m_scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) // scale between minimum and maximum. called after any 'bounce' animations
    

    optional  func m_scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool // return a yes if you want to scroll to the top. if not defined, assumes YES

    optional  func m_scrollViewDidScrollToTop(scrollView: UIScrollView) // called when scrolling animation finished. may be called immediately if already at top
    
}

public class SCMultipleTableView: UIView ,UITableViewDataSource,UITableViewDelegate {
    
   public var tableView :UITableView!
   public  var currentOpenedIndexPaths :Array<NSIndexPath>? = []//当前展开的所有cell的indexPath的数组
    
    weak public var multipleDelegate : SCMultipleTableDelegate? //多重表格代理
    
    public init(frame: CGRect ,style:UITableViewStyle) {
        super.init(frame: frame)
        tableView = UITableView(frame: frame, style: style)
        tableView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .None
        self.addSubview(tableView!)
    }
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
    
    //=======================================//
    //          Mark :public methods          //
    //=======================================//
    /**
     根据标识符取出重用cell
     
     :param: identifier 标识符
     
     :returns: 可重用的cell，或者nil（如果没有可重用的）
     */
  public  func dequeueReusableCellWithIdentifier(identifier :String)->UITableViewCell?{
        
        return self.tableView.dequeueReusableCellWithIdentifier(identifier)
        
    }
    
    /**
     根据标识符 与cell索引取出可以重用的cell
     
     :param: identifier 标识符
     :param: indexPath  cell索引
     
     :returns:可重用的cell，或者nil（如果没有可重用的）
     */
   public func dequeueReusableCellWithIdentifier(identifier :String ,forIndexPath indexPath :NSIndexPath) ->UITableViewCell?{
        
        return self.tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
    }
    
    
    
    /**
     根据标识符,取出可以重用的section headView or section footView
     
     :param: identifier 标识符
     
     :returns: 可重用的section headView or section footView
     */
   public func dequeueReusableHeaderFooterViewWithIdentifier(identifier:String)->UITableViewHeaderFooterView?{
        
        return self.tableView.dequeueReusableHeaderFooterViewWithIdentifier(identifier)
    }
    
    
    
    /**
     取消表格选中状态
     
     :param: indexPath 单元格索引
     :param: animate
     */
   public func deselectRowAtIndexPath(indexPath:NSIndexPath, animated animate:Bool)->Void{
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: animate)
    }
    
    /**
     刷新数据
     */
   public func reload() ->Void{
        
        
        self.tableView!.reloadData()
    }
    
    /**
     刷新某一section的单元格
     
     :param: sections   需要重新刷新数据的section
     :param: animation 动画
     */
    public func reloadSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation){
        
        
        self.tableView.reloadSections(sections, withRowAnimation: animation)
        
    }
    
    //=======================================//
    //          Mark : private UITapGestureRecognizer             //
    //=======================================//
    
    /**
     为view添加一个tap手势，其行为为action
     
     :param: anction 要添加的手势含有的行为
     :param: view    需要添加手势的视图
     */
    private func addTapGestureRecognizerAction(anction:Selector,toView view:UIView) ->Void{
        
        let tapGR = UITapGestureRecognizer(target: self, action: anction)
        view.addGestureRecognizer(tapGR)
    }
    
    
    /**
     为view移除一个tap手势
     
     :param: view 要移除手势的view
     */
    private func removeTapGestureRecognizerInView(view:UIView) ->Void{
        
        let gestures = view.gestureRecognizers! as [UIGestureRecognizer]
        
        for  gr in gestures {
            
            if gr.view!.isEqual(view){
                
                view.removeGestureRecognizer(gr)
            }
        }
    }
    
    
    
    
    /**
     添加在header中的点击手势的方法
     
     :param: gesture 点击手势
     */
    @objc private func tableViewHeaderTouchUpInside(gesture : UITapGestureRecognizer) ->Void{
        
        let section = gesture.view?.tag
        
        openOrCloseRowWithSection(section!)
        
    }
    
    
    
    //.=======================================//
    //     Mark :open or close section row    //
    //=======================================//
    
    /**
     展开或者收起section中的row
     
     :param: section tableView 中的section
     */
    
    private func openOrCloseRowWithSection(section :Int) ->Void{
        
        var openedIndexPaths :Array<NSIndexPath>? = []//展开的表格
        var deleteIndexPaths :Array<NSIndexPath>? = []//收起的表格
        
        //判断当前是否有row被展开
        if self.currentOpenedIndexPaths?.count == 0 {
            
            //当前没有任何子列表被打开
            openedIndexPaths = self.indexPathsForOpenRowFromSection(section)
            
        }else{
            //当前有row被展开
            var found = false
            
            //遍历
            for ip in self.currentOpenedIndexPaths!{
                
                //关闭当前已经打开的子列表
                if ip.section == section{
                    found = true
                    deleteIndexPaths = self.indexPathsForCloseRowFromSection(section)
                    break
                }
            }
            
            //展开新的section
            if !found {
                
                openedIndexPaths = self.indexPathsForOpenRowFromSection(section)
                
            }
            
        }
        
        self.tableView.beginUpdates()
        
        if openedIndexPaths?.count > 0 {
            self.tableView.insertRowsAtIndexPaths(openedIndexPaths!, withRowAnimation: .Automatic)
        }
        
        
        if deleteIndexPaths?.count > 0 {
            
            self.tableView.deleteRowsAtIndexPaths(deleteIndexPaths!, withRowAnimation: .Automatic)
        }
        self.tableView.endUpdates()
        
        let range = NSRange(location: section, length: 1)
        let indexSet = NSIndexSet(indexesInRange: range)
        self.tableView.reloadSections(indexSet, withRowAnimation: .Automatic)
    }
    
    /**
     展开一个section 中的row
     
     :param: section 待展开的row所在的section
     
     :return:  该section内所有indexPath信息
     */
    private func indexPathsForOpenRowFromSection(section:Int) ->Array<NSIndexPath>?{
        
        var indexPaths :Array<NSIndexPath>? = []
        
        let rowCount = get_numberOfRowsInSection(section)
        
        //调用代理,判断代理是否实现展开section row 的方法
        if self.multipleDelegate != nil && self.multipleDelegate!.respondsToSelector(#selector(SCMultipleTableDelegate.m_tableView(_:willOpenSubRowFromSection:))) {
            //如果实现该方法，
            self.multipleDelegate?.m_tableView!(self, willOpenSubRowFromSection: section)
        }
        
        //打开了第section个子列表
        self.currentOpenedIndexPaths?.append(NSIndexPath(forRow: -1, inSection: section))
        
        //往当前section中添加row
        
        for i in 0 ..< rowCount {
            
            indexPaths?.append(NSIndexPath(forRow: i , inSection: section))
            
        }
        
        return indexPaths
    }
    
    
    
    /**
     收起已经展开的section
     
     :param: section 需要收起的section
     
     :returns: 该section内所有indexPath信息
     */
    private func indexPathsForCloseRowFromSection(section:Int) -> Array<NSIndexPath>?{
        
        var indexPathS :Array<NSIndexPath>? = []
        
        let rowCount = self.get_numberOfRowsInSection(section)
        
        //判断代理是否实现收起section中的行
        if self.multipleDelegate != nil && self.multipleDelegate!.respondsToSelector(#selector(SCMultipleTableDelegate.m_tableView(_:willCloseSubRowFromSection:))) {
            
            self.multipleDelegate?.m_tableView!(self, willCloseSubRowFromSection: section)
        }
        
        //遍历数组，删除元素
        for (index ,value ) in (self.currentOpenedIndexPaths?.enumerate())!{
            
            if value.section == section{
                
                self.currentOpenedIndexPaths?.removeAtIndex(index)
                break
            }
            
        }
        
        
        //关闭第section个子列表
        for i in 0..<rowCount{
            
            indexPathS?.append(NSIndexPath(forRow: i , inSection: section))
        }
        
        
        return indexPathS
        
    }
    
    
    //.=======================================//
    //          Mark :  UITableViewDateSource        //
    //=======================================//
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //查找没有打开row 的section
        var found = false
        
        for ip in self.currentOpenedIndexPaths!{
            if section == ip.section {
                
                found = true
                break
            }
            
        }
        //判断row 是否已经打开
        if found {
            //如果打开了，则需要计算该section下有多少row
            
            return get_numberOfRowsInSection(section)
            
        }else{
            //如果没有打开，则返回0
            return 0
        }
    }
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var height :CGFloat = 0
        if self.multipleDelegate != nil &&  self.multipleDelegate!.respondsToSelector(#selector(SCMultipleTableDelegate.m_tableView(_:heightForRowAtIndexPath:))){
            
            height = (self.multipleDelegate?.m_tableView!(self, heightForRowAtIndexPath: indexPath))!
        }
        
        return height
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        return get_cellForRowAtIndexPath(indexPath)
    }
    
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return get_numberOfSection()
    }
    
    //.=======================================//
    //          Mark :UITableDelegate          //
    //=======================================//
    
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        get_didSelectRowAtIndexPath(indexPath)
    }
    
    
    public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        
        var height :CGFloat = 0
        
        if self.multipleDelegate != nil && self.multipleDelegate!.respondsToSelector(#selector(SCMultipleTableDelegate.numberOfSectionsInSCMutlipleTableView(_:))){
            
            height = get_heightForHeaderInSection(section)
        }
        
        return height
    }
    
    
    public func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        var height :CGFloat = 0
        
        if self.multipleDelegate != nil && self.multipleDelegate!.respondsToSelector(#selector(SCMultipleTableDelegate.numberOfSectionsInSCMutlipleTableView(_:))){
            
            height = get_heightForFootInSection(section)
        }
        
        return height
        
    }
    
    
    
    public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headView = get_viewForHeaderInSection(section)
        
        if headView != nil{
            
            let height  = self.tableView(tableView, heightForHeaderInSection: section)
            headView?.frame = CGRectMake(0, 0, self.tableView!.frame.size.width, height)
            headView?.tag = section
        }
        
        
        //给section headView 添加点击事件
        addTapGestureRecognizerAction(#selector(SCMultipleTableView.tableViewHeaderTouchUpInside(_:)), toView: headView!)
        
        return headView
        
    }
    
    //.=======================================//
    //          Mark :  private func         //
    //=======================================//
    
    
    /**
     获取每个section中的row数目
     
     :param: section 表格中的section
     
     :returns: section中的row数目
     */
    private func get_numberOfRowsInSection(section:Int) ->Int{
        
      //  var row = self.multipleDelegate?.m_tableView(self, numberOfRowsInSection: section) ?? 0
        
        var row : Int = 0

        if self.multipleDelegate != nil && self.multipleDelegate!.respondsToSelector(#selector(SCMultipleTableDelegate.m_tableView(_:numberOfRowsInSection:))) {
            
            row = self.multipleDelegate!.m_tableView(self, numberOfRowsInSection: section)
        }
        
        return row
        
    }
    
    
    /**
     获取表格中的section数目
     
     :returns: 获取表格中的section数目
     */
    private func get_numberOfSection() ->Int{
        
        var number = 0
        
        if self.multipleDelegate != nil && self.multipleDelegate!.respondsToSelector(#selector(SCMultipleTableDelegate.numberOfSectionsInSCMutlipleTableView(_:))) {
            
            number = (self.multipleDelegate?.numberOfSectionsInSCMutlipleTableView!(self))!
        }
        
        return number
    }
    
    
    /**
     获取tableView 中的单元格
     
     :param: indexPath 表格索引
     
     :returns: 返回tableView中的单元格
     */
    private func get_cellForRowAtIndexPath(indexPath:NSIndexPath) ->UITableViewCell{
        
        var cell :UITableViewCell?
        if self.multipleDelegate != nil && self.multipleDelegate!.respondsToSelector(#selector(SCMultipleTableDelegate.m_tableView(_:cellForRowAtIndexPath:))) {
            
            cell = self.multipleDelegate?.m_tableView(self, cellForRowAtIndexPath: indexPath)
        }
        
        return cell!
    }
    
    
    
    /**
     获取点中的单元格
     
     :param: indexPath 单元格索引
     */
    private func get_didSelectRowAtIndexPath(indexPath:NSIndexPath) ->Void{
        
        if self.multipleDelegate != nil && self.multipleDelegate!.respondsToSelector(#selector(SCMultipleTableDelegate.m_tableView(_:didSelectRowAtIndexPath:))) {
            
            self.multipleDelegate?.m_tableView!(self, didSelectRowAtIndexPath: indexPath)
        }
    }
    
    
    /**
     获取tableView section头部高度
     
     :param: section section索引
     
     :returns: 返回section头部高度
     */
    private func get_heightForHeaderInSection(section:Int) ->CGFloat{
        
        var height:CGFloat = 0
        
        if self.multipleDelegate != nil && self.multipleDelegate!.respondsToSelector(#selector(SCMultipleTableDelegate.m_tableView(_:heightForHeaderInSection:))) {
            
            height = (self.multipleDelegate?.m_tableView!(self, heightForHeaderInSection: section))!
        }
        
        return height
        
    }
    
    
    
    /**
     获取tableView section尾部
     
     :param: section section索引
     
     :returns: 返回section尾部高度
     */
    private func get_heightForFootInSection(section:Int) ->CGFloat{
        
        var height:CGFloat = 0
        
        if self.multipleDelegate != nil && self.multipleDelegate!.respondsToSelector(#selector(SCMultipleTableDelegate.m_tableView(_:heightForFootInSection:))) {
            
            height = (self.multipleDelegate?.m_tableView!(self, heightForFootInSection: section))!
        }
        
        return height
        
    }
    
    /**
     获取section headView
     
     :param: section tableView section索引
     
     :returns: tableView section headView
     */
    private func get_viewForHeaderInSection(section:Int) ->UIView?{
        
        var view :UIView?
        if self.multipleDelegate != nil && self.multipleDelegate!.respondsToSelector(#selector(SCMultipleTableDelegate.m_tableView(_:viewForHeaderInSection:))) {
            
            view = self.multipleDelegate?.m_tableView!(self, viewForHeaderInSection: section)
        }
        
        return view
    }
    
    //MARK: UIScrollViewDelegate
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        
            
        self.multipleDelegate?.m_scrollViewDidScroll?(scrollView)

    }
    
    public func scrollViewDidZoom(scrollView: UIScrollView) {

            
        self.multipleDelegate?.m_scrollViewDidZoom?(scrollView)
    }
    
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {

            
        self.multipleDelegate?.m_scrollViewWillBeginDragging?(scrollView)
    }
    
    
    public func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
            
        self.multipleDelegate?.m_scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {

            
        self.multipleDelegate?.m_scrollViewDidEndDecelerating?(scrollView)
    }
    
    
    public func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
            
        self.multipleDelegate?.m_scrollViewDidEndScrollingAnimation?(scrollView)
    }
    
    public func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        var view :UIView?
            
        view = self.multipleDelegate?.viewForZoomingInScrollView?(scrollView)
        
        return view
    }
    
    public func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView?) {

            
        self.multipleDelegate?.m_scrollViewWillBeginZooming?(scrollView, withView: view)
    }
    
    public func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {

            
        self.multipleDelegate?.m_scrollViewDidEndZooming?(scrollView, withView: view, atScale: scale)

    }
    
    public func scrollViewDidScrollToTop(scrollView: UIScrollView) {

        self.multipleDelegate?.m_scrollViewDidScrollToTop?(scrollView)
    }
    
    
    public func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {            
        return self.multipleDelegate?.m_scrollViewShouldScrollToTop?(scrollView) ?? false
    }
    
}
