//
//  ViewController.swift
//  wjGuidePage
//
//  Created by jerry on 2017/8/2.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.wjNavigationSettings()
        self.wjUISettings()
    }
    
    // 导航栏设置
    func wjNavigationSettings() {
        self.title = "登录界面"
        // 恢复isShowGuidePage为false
        let btn = UIButton(type: .custom)
        btn.setTitle("重置", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.bounds = CGRect(x: 0, y: 0, width: 50, height: 30)
        btn.addTarget(self, action: #selector(ViewController.wjModifyDataAction(_ :)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
    }

    // UI界面的设置
    func wjUISettings() {
        let userNameTF = UITextField()
        let passwordTF = UITextField()
        userNameTF.frame = CGRect(x: 62.5, y: 100, width: 250, height: 30)
        passwordTF.frame = CGRect(x: 62.5, y: 180, width: 250, height: 30)
        userNameTF.borderStyle = UITextBorderStyle.roundedRect
        passwordTF.borderStyle = UITextBorderStyle.roundedRect
        userNameTF.placeholder = "请输入账号名"
        passwordTF.placeholder = "请输入密码"
        self.view.addSubview(userNameTF)
        self.view.addSubview(passwordTF)
        
        
        // 设置服务器的按钮创建
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 127.5, y: 500, width: 120.0, height: 30.0)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10
        btn.backgroundColor = UIColor.cyan
        btn.setTitle("服务器选择", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(ViewController.wjServerSelect), for: .touchUpInside)
        self.view.addSubview(btn)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}

// MARK:- 按钮的点击事件
extension ViewController {
    // 修改存在本地的数据
    func wjModifyDataAction(_ btn : UIButton) {
        UserDefaults.standard.set(false, forKey: "isShowGuidePage")
        self.dismiss(animated: true, completion: nil)
    }
    
    // 进行服务器选择界面的跳转
    func wjServerSelect() {
        // 进行跳转
        let selectVC = wjServerSelectVC()
        self.present(selectVC, animated: true, completion: nil)
    }
    
    
    
}
