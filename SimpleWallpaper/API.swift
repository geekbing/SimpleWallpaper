//
//  API.swift
//  SimpleWallpaper
//
//  Created by Bing on 7/4/16.
//  Copyright © 2016 Bing. All rights reserved.
//

import Foundation


let baseAPI = "https://api.unsplash.com/"

let applicationID = "6d6617b8a83144e7b545c21b1aa5c73d017fe65123730480fb229b81a7c9cfe7"
let secret = "208cab65ca6159408d218795f5a7420eff2d3cbfd1aa83ccda14c21d3b0d2293"

// 获取壁纸
func getData(limit: Int, skip: Int, callback: (results: [AVObject]) -> ())
{
    let query = AVQuery(className: "Wallpaper")
    query.limit = limit
    query.skip = skip
    query.addDescendingOrder("createdAt")
    
    query.findObjectsInBackgroundWithBlock { (results: [AnyObject]!, error: NSError!) in
        callback(results: results as! [AVObject])
    }
}

func saveImage(thumbnailString thumbnailString: String, originString: String)
{
    let wallpaper = AVObject(className: "Wallpaper")
    // 缩略图
    let thumbnailImage = UIImage(named: thumbnailString)
    let thumbnailFile = AVFile(data: UIImagePNGRepresentation(thumbnailImage!))
    // 大图
    let originImage = UIImage(named: originString)
    let originFile = AVFile(data: UIImagePNGRepresentation(originImage!))

    thumbnailFile.saveInBackgroundWithBlock { (success: Bool, error: NSError!) in
        if success
        {
            originFile.saveInBackgroundWithBlock({ (success2: Bool, error2: NSError!) in
                if success2
                {
                    wallpaper.setObject(thumbnailFile, forKey: "Thumbnail")
                    wallpaper.setObject(originFile, forKey: "OriginImage")
                    wallpaper.saveInBackgroundWithBlock({ (success3: Bool, error3: NSError!) in
                        if success3
                        {
                            print("保存成功")
                        }
                        else
                        {
                            print("保存失败")
                        }
                    })
                }
            })
        }
        else
        {
            
        }
    }
}
