//
//  Register.swift
//  SimpleWallpaper
//
//  Created by Bing on 7/4/16.
//  Copyright © 2016 Bing. All rights reserved.
//

import UIKit
import Material
import SVProgressHUD

class Register: UIViewController
{
    // 用户名
    var username: TextField!
    // 密码
    var password: TextField!
    // 邮箱
    var email: TextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        // 模糊背景
        let background = UIImageView()
        background.image = UIImage(named: "background3")?.blurImage()
        view.addSubview(background)
        
        // 关闭按钮
        let closeBtn = IconButton()
        closeBtn.setImage(UIImage(named: "close")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
        closeBtn.tintColor = UIColor.flatWhiteColor()
        closeBtn.addTarget(self, action: .closeBtnClick, forControlEvents: .TouchUpInside)
        view.addSubview(closeBtn)

        // Logo
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.layer.masksToBounds = true
        logo.layer.cornerRadius = 40
        view.addSubview(logo)
        
        // 用户名
        username = TextField()
        username.placeholderVerticalOffset = 6.0
        username.placeholderColor = UIColor.flatWhiteColor()
        username.placeholderActiveColor = UIColor.flatWhiteColor()
        username.dividerColor = UIColor.flatWhiteColor()
        username.dividerActiveColor = UIColor.flatWhiteColor()
        username.textColor = UIColor.flatWhiteColor()
        username.placeholder = "用户名"
        username.font = font14
        view.addSubview(username)
        
        // 密码
        password = TextField()
        password.placeholderVerticalOffset = 6.0
        password.placeholderColor = UIColor.flatWhiteColor()
        password.placeholderActiveColor = UIColor.flatWhiteColor()
        password.dividerColor = UIColor.flatWhiteColor()
        password.dividerActiveColor = UIColor.flatWhiteColor()
        password.textColor = UIColor.flatWhiteColor()
        password.secureTextEntry = true
        password.placeholder = "密码"
        password.font = font14
        view.addSubview(password)
        
        // 邮箱
        email = TextField()
        email.placeholderVerticalOffset = 6.0
        email.placeholderColor = UIColor.flatWhiteColor()
        email.placeholderActiveColor = UIColor.flatWhiteColor()
        email.dividerColor = UIColor.flatWhiteColor()
        email.dividerActiveColor = UIColor.flatWhiteColor()
        email.textColor = UIColor.flatWhiteColor()
        email.secureTextEntry = true
        email.placeholder = "邮箱"
        email.font = font14
        view.addSubview(email)
        
        // 注册按钮
        let register = UIButton()
        register.layer.masksToBounds = true
        register.layer.cornerRadius = 20
        register.setTitle("注册", forState: .Normal)
        register.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        register.backgroundColor = UIColor.flatRedColor()
        register.addTarget(self, action: .registerClick, forControlEvents: .TouchUpInside)
        view.addSubview(register)
        
        // 布局
        background.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        closeBtn.snp_makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.top.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        logo.snp_makeConstraints { (make) in
            make.width.height.equalTo(80)
            make.top.equalTo(view).offset(80)
            make.centerX.equalTo(view.snp_centerX)
        }
        username.snp_makeConstraints { (make) in
            make.top.equalTo(logo).offset(100)
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
            make.height.equalTo(30)
        }
        password.snp_makeConstraints { (make) in
            make.top.equalTo(username.snp_bottom).offset(20)
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
            make.height.equalTo(30)
        }
        email.snp_makeConstraints { (make) in
            make.top.equalTo(password.snp_bottom).offset(20)
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
            make.height.equalTo(30)
        }
        register.snp_makeConstraints { (make) in
            make.top.equalTo(email.snp_bottom).offset(30)
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
            make.height.equalTo(40)
        }
    }
    
    // 点击关闭按钮
    func closeBtnClick()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // 点击注册按钮
    func registerClick()
    {
        SVProgressHUD.show()
        let newUser = AVUser()
        newUser.username = username.text
        newUser.password = password.text
        newUser.email = email.text
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError!) in
            if success
            {
                self.resignFirstResponder()
                SVProgressHUD.showSuccessWithStatus("注册成功!")
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            else
            {
                SVProgressHUD.showErrorWithStatus(error.localizedDescription)
            }
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

private extension Selector
{
    static let closeBtnClick = #selector(Register.closeBtnClick)
    static let registerClick = #selector(Register.registerClick)
}
