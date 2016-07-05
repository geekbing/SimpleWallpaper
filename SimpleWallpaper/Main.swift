//
//  Main.swift
//  SimpleWallpaper
//
//  Created by Bing on 7/4/16.
//  Copyright © 2016 Bing. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD

class Main: UIViewController
{
    var tableView: UITableView!
    var dataArr = [AVObject]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.tableView.registerClass(ImageCell.classForCoder(), forCellReuseIdentifier: "ImageCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: .headerRefresh)
        self.tableView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: .footerRefresh)
        self.view.addSubview(self.tableView)
        
        
        SVProgressHUD.show()
        getData(10, skip: 0) { (results) in
            SVProgressHUD.showSuccessWithStatus("更新成功")
            self.dataArr = results
            self.tableView.reloadData()
        }
    }
    
    // 下拉刷新
    func headerRefresh()
    {
        let query = AVQuery(className: "Wallpaper")
        query.orderByDescending("createdAt")
        query.limit = 10
        query.skip = 0
        query.findObjectsInBackgroundWithBlock { (result: [AnyObject]!, error: NSError!) in
            self.tableView.mj_header.endRefreshing()
            self.dataArr.removeAll()
            self.dataArr.appendContentsOf(result as! [AVObject])
            self.tableView.reloadData()
        }
        
    }
    
    // 下拉加载
    func footerRefresh()
    {
        let query = AVQuery(className: "Wallpaper")
        query.orderByDescending("createdAt")
        query.limit = 10
        query.skip = self.dataArr.count
        query.findObjectsInBackgroundWithBlock { (result: [AnyObject]!, error: NSError!) in
            self.tableView.mj_footer.endRefreshing()
            self.dataArr.appendContentsOf(result as! [AVObject])
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

private extension Selector
{
    static let headerRefresh = #selector(Main.headerRefresh)
    static let footerRefresh = #selector(Main.footerRefresh)
}

extension Main: UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCell
        
        let object = self.dataArr[indexPath.row] as AVObject
        let thumbnailfile = object["Thumbnail"] as! AVFile
        cell.imageView?.sd_setImageWithURL(NSURL(string: thumbnailfile.url), placeholderImage: UIImage(named: "default"))
        return cell
    }
}

extension Main: UITableViewDelegate
{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 200
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print(indexPath.row)
    }
}