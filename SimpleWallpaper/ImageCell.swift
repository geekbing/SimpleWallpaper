//
//  ImageCell.swift
//  SimpleWallpaper
//
//  Created by Bing on 7/4/16.
//  Copyright © 2016 Bing. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell
{
    var imgView: UIImageView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 初始化图片
        self.imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 200))
        self.imgView?.contentMode = .ScaleAspectFit
        self.contentView.addSubview(self.imgView!)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}