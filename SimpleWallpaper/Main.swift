//
//  Main.swift
//  SimpleWallpaper
//
//  Created by Bing on 7/4/16.
//  Copyright © 2016 Bing. All rights reserved.
//

import UIKit

class Main: UIViewController
{
    var tableView: UITableView!
    var dataArr = ["", "", "", "", ""]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.tableView.registerClass(ImageCell.classForCoder(), forCellReuseIdentifier: "ImageCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
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
        
//        cell.imageView?.sd_setImageWithURL(NSURL(string: "https://source.unsplash.com/category/nature"), placeholderImage: UIImage(named: ""))
        
        cell.imgView?.image = UIImage(named: "test.jpg")
        
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