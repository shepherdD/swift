//
//  ViewController.swift
//  Call
//
//  Created by wudi on 2019/3/13.
//  Copyright © 2019 BigGun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var mainView: UIView!
    var mainLb1: UILabel!
    var mainLb2: UILabel!
    var settingView: SettingView!
    var labelArr: NSMutableArray = []
    var currentFrame: CGRect = CGRect.init()
    var behindFrame: CGRect = CGRect.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI();
    }

    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        self.startAnim()
    }
    
    func initUI() {
        // 初始化父视图
        self.mainView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height))
        self.view.addSubview(self.mainView)
        self.mainView.backgroundColor = UIColor.black
        // 初始化跑马灯视图
        self.mainLb1 = UILabel.init(frame: CGRect.init(x: UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height))
        self.mainLb2 = UILabel.init(frame: CGRect.init(x: UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height))
        self.mainView.addSubview(self.mainLb1)
        self.mainView.addSubview(self.mainLb2)
        self.setContentFont(font: UIFont.boldSystemFont(ofSize: 180))
        self.setContentText(text: "Call")
        self.setContentColor(color: UIColor.white)
        currentFrame = self.mainLb1.frame
        behindFrame = self.mainLb2.frame
        labelArr.add(self.mainLb1)
        labelArr.add(self.mainLb2)
    }
    
    func setContentFont(font: UIFont) {
        self.mainLb1.font = font
        self.mainLb2.font = font
    }
    
    func setContentText(text: String) {
        self.mainLb1.text = text
        self.mainLb2.text = text
        self.mainLb1.sizeToFit()
        self.mainLb1.frame = CGRect.init(x: 0, y: 0, width: self.mainLb1.frame.size.width, height: UIScreen.main.bounds.size.height)
        self.mainLb2.sizeToFit()
        self.mainLb2.frame = CGRect.init(x: self.mainLb1.frame.origin.x+self.mainLb1.frame.size.width, y: 0, width: self.mainLb2.frame.size.width, height: UIScreen.main.bounds.size.height)
    }
    
    func setContentColor(color: UIColor) {
        self.mainLb1.textColor = color;
        self.mainLb2.textColor = color;
    }
    
    func startAnim() {
        UIView.animate(withDuration: 3, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            let label1: UILabel = self.labelArr[0] as! UILabel
            let label2: UILabel = self.labelArr[1] as! UILabel
            let offset = self.currentFrame.size.width
            label1.transform = CGAffineTransform.init(translationX: -offset, y: 0)
            label2.transform = CGAffineTransform.init(translationX: -offset, y: 0)
        }) { (void) in
            let label1: UILabel = self.labelArr[0] as! UILabel
            let label2: UILabel = self.labelArr[1] as! UILabel
            label1.transform = CGAffineTransform.identity
            label1.frame = self.behindFrame
            label2.transform = CGAffineTransform.identity
            label2.frame = self.currentFrame
            self.labelArr.replaceObject(at: 1, with: label1)
            self.labelArr.replaceObject(at: 0, with: label2)
            self.startAnim()
        }
    }
    
    func showSetting() {
        // 显示设置视图
    }
}

