//
//  wjGuideVC.swift
//  wjGuidePage
//
//  Created by jerry on 2017/8/2.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

class wjGuideVC: UIViewController {
    
    // 一些声明
    var scrollView : UIScrollView!
    var pageControl : UIPageControl!
    var images : NSMutableArray!
    var imageView : UIImageView!
    
    
    
    // MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        self.wjUISettings()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.wjNavgationSettings()
    }
    
    // 隐藏状态栏
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    // ui设置
    func wjUISettings() {
        
        self.images = NSMutableArray(capacity: 0)
        let imageArray = NSArray(contentsOfFile: Bundle.main.path(forResource: "data", ofType: "plist")!)
        if let imgArr = imageArray {
            self.images.addObjects(from: imgArr as Array)
            
        }
        let imageCount : Double = Double(self.images.count)
        let screenW = UIScreen.main.bounds.size.width //self.view.frame.size.width
        let screenH = UIScreen.main.bounds.size.height // self.view.frame.size.height
        
        // 创建轮播图
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: screenW, height: screenH) //self.view.frame
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.contentSize = CGSize(width: Double(screenW) * imageCount, height: 0)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = UIColor.brown
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        self.scrollView = scrollView
        
        // 创建图片
        for i in 0..<Int(imageCount) {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "gagi\(i + 1)")
            imageView.frame = CGRect(x: Double(screenW) * Double(i), y: 0, width: Double(screenW), height: Double(screenH))
            imageView.isUserInteractionEnabled = true // 为的是响应链能够被传递，不然后添加在其上面的按钮的点击事件就不能被执行了
            scrollView.addSubview(imageView)
            self.imageView = imageView
        }
        
        
        
        let pageControl = UIPageControl()
        pageControl.frame = CGRect(x: 137.5, y: 600.0, width: 100.0, height: 20.0)
        pageControl.isUserInteractionEnabled = false
        pageControl.hidesForSinglePage = true
        pageControl.currentPage = 0
        pageControl.numberOfPages = Int(imageCount)
        self.view .addSubview(pageControl)
        self.pageControl = pageControl
    }
    
    /// 导航栏设置
    func wjNavgationSettings() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
}

// MARK:- 代理
extension wjGuideVC : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(self.scrollView.contentOffset.x / scrollView.frame.size.width + 0.5)
        self.pageControl.currentPage = page
        // 如果在最后一张照片出现的时候就要创建一个按钮，进行点击，然后跳转
        if page == self.images.count - 1 {
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: 112.5, y: 500, width: 150.0, height: 50.0)
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = 10
            btn.backgroundColor = UIColor.cyan
            btn.setTitle("点 击 进 行 跳 转", for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.addTarget(self, action: #selector(wjGuideVC.wjModifyRootVCAction(_ :)), for: .touchUpInside)
            self.imageView.addSubview(btn)
        }
    }
}



// MARK:- 按钮的点击事件
extension wjGuideVC {
    // 修改根控制器的按钮点击事件
    func wjModifyRootVCAction(_ btn : UIButton) {
        let vc = ViewController()
        vc.navigationController?.navigationBar.isHidden = false
        // 把已经出现过的引导页的结果记录到本地
        UserDefaults.standard.set(true, forKey: "isShowGuidePage")
        // 这个地方完全可以将app的version也存到本地去，然后在每次进入到app的时候就判断版本号
        let app = AppDelegate()
        let nav = UINavigationController(rootViewController: vc)
        app.window?.rootViewController = nav
        self.present(nav, animated: true, completion: nil)

    }
}
