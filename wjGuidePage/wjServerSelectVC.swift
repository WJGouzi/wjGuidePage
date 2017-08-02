//
//  wjServerSelectVC.swift
//  wjGuidePage
//
//  Created by jerry on 2017/8/2.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

class wjServerSelectVC: UIViewController {
    
    var tableView : UITableView!
    var serverNameTF : UITextField!
    var passwordTF : UITextField!
    
    
    
    // 懒加载
    lazy var wjServerListArr : NSMutableArray = {
        let dataArray = NSArray(contentsOfFile: Bundle.main.path(forResource: "serverListData", ofType: "plist")!)
        let wjServerListArr = NSMutableArray(capacity: 0)
        for dict in dataArray! {
            let dataDict = dict as! [String : String]
            let model = wjServerModel().wjServerModelWithDict(dataDict)
            wjServerListArr.add(model)
        }
        return wjServerListArr
    }()
    

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
        self.serverNameTF = serverNameTF
        self.passwordTF = passwordTF
        
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
        // 创建tableView
        
        if (self.serverNameTF.text?.characters.count)! != 0 && (self.passwordTF.text?.characters.count)! != 0 {
            // 当有字符输入的时候才进行创建
            self.wjCreatTableView()
        } else {
            self.wjShowAlertView("完善账号和密码")
        }
        
    }
    
    
    func wjCreatTableView() {
        let screenW = self.view.frame.size.width
        let screenH = self.view.frame.size.height
        let rect = CGRect(x: 0, y: 250, width: Double(screenW), height: Double(screenH - 250))
        UIView.animate(withDuration: 0.5) { 
            self.tableView = UITableView(frame: rect, style: UITableViewStyle.plain)
            self.tableView.backgroundColor = UIColor.white
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.view.addSubview(self.tableView)
        }
    }

}

// MARK:- UITableViewDataSource
extension wjServerSelectVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wjServerListArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let iden = "serverCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: iden)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: iden)
        }
        let model = self.wjServerListArr[indexPath.row] as! wjServerModel
        cell?.textLabel?.text = model.serverName
        cell?.detailTextLabel?.text = model.serverIP
        return cell!
    }
    
}


// MARK:- UITableViewDelegate
extension wjServerSelectVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 创建弹出框
        
//        let model = self.wjServerListArr[indexPath.row] as! wjServerModel
//        print("index is : \(model.serverName) : \(model.serverIP)")
        self.wjShowMessage(indexPath, "选择此服务器?") { (model) in
            print("index is : \(model.serverName) : \(model.serverIP)")
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK:- 通用方法
extension wjServerSelectVC {
    
    /// 显示提示框
    func wjShowAlertView( _ message : String) {
        let alertVC = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "确定", style: .default) { (action) in
            
        }
        let cancle = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertVC.addAction(action)
        alertVC.addAction(cancle)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func wjShowMessage(_ index : IndexPath, _ message : String, completion: @escaping (_ model: wjServerModel) -> ()) {
        let alertVC = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "确定", style: .default) { (actions) in
            let model = self.wjServerListArr[index.row] as! wjServerModel
            completion(model)
        }
        let cancle = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertVC.addAction(action)
        alertVC.addAction(cancle)
        self.present(alertVC, animated: true, completion: nil)
    }
    
}



