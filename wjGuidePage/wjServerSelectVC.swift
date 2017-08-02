//
//  wjServerSelectVC.swift
//  wjGuidePage
//
//  Created by jerry on 2017/8/2.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

class wjServerSelectVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.wjUISettings()
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }

    // UI界面的设置
    func wjUISettings() {
        let serverNameTF = UITextField()
        let passwordTF = UITextField()
        serverNameTF.frame = CGRect(x: 62.5, y: 100, width: 250, height: 30)
        passwordTF.frame = CGRect(x: 62.5, y: 150, width: 250, height: 30)
        serverNameTF.borderStyle = UITextBorderStyle.roundedRect
        passwordTF.borderStyle = UITextBorderStyle.roundedRect
        serverNameTF.placeholder = "请输入服务器地址"
        passwordTF.placeholder = "请输入服务器密码"
        self.view.addSubview(serverNameTF)
        self.view.addSubview(passwordTF)
        
        
        // 设置服务器的按钮创建
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 127.5, y: 200, width: 120.0, height: 30.0)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10
        btn.backgroundColor = UIColor.cyan
        btn.setTitle("服务器选择", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(wjServerSelectVC.wjServerSelectAction), for: .touchUpInside)
        self.view.addSubview(btn)
        
    }
}


// MARK:- 按钮的点击事件
extension wjServerSelectVC {
    func wjServerSelectAction() {
        print("选择")
        // 创建tableView
        
    }
}



