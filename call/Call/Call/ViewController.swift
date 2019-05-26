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
    var mainLb: UILabel!
    var mainBg: UIImageView!
    var settingView: SettingView!
    var gitImages = [UIImage]()
    var textFiled: UITextField!
    var settingBtn: UIButton!
    var isAnimStop: Bool = false
    
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
        self.view.backgroundColor = UIColor.init(red: 40.0/255.0, green: 43.0/255.0, blue: 53.0/255.0, alpha: 1.0)
        self.mainView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height))
        self.view.addSubview(self.mainView)
        self.mainView.backgroundColor = UIColor.init(red: 40.0/255.0, green: 43.0/255.0, blue: 53.0/255.0, alpha: 1.0)
        self.mainBg = UIImageView.init(frame: self.mainView.bounds)
        self.mainView.addSubview(self.mainBg)
        // 初始化跑马灯视图
        self.mainLb = UILabel.init()
        self.mainView.addSubview(self.mainLb)
        self.setContentFont(font: UIFont.boldSystemFont(ofSize: 180))
        self.setContentColor(color: UIColor.white)
        self.setContentText(text: "1")
        // 输入框
        let width = UIScreen.main.bounds.size.width - 200.0
        let height: CGFloat = 40.0
        let originX: CGFloat = 100.0
        let originY = UIScreen.main.bounds.size.height - height - 17.0
        self.textFiled = UITextField.init(frame: CGRect.init(x: originX, y: originY, width: width, height: height))
        self.textFiled.backgroundColor = UIColor.white
        self.textFiled.layer.cornerRadius = height/2
        self.textFiled.font = UIFont.systemFont(ofSize: 30)
        self.textFiled.layer.masksToBounds = true
        self.textFiled.placeholder = "   请输入滚动文字"
        self.textFiled.delegate = self
        self.view.addSubview(self.textFiled)
    }
    
    func setContentText(text: String) {
        var newStr = text
        for _ in 0...20 {
            newStr = newStr + " " + text
        }
        self.mainLb.text = newStr
        self.mainLb.sizeToFit()
        self.mainView.frame = CGRect.init(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: self.mainLb.frame.size.width)
        // 旋转label
        self.mainLb.layer.anchorPoint = CGPoint.init(x: 0, y: 0)
        self.mainLb.frame = CGRect.init(x: UIScreen.main.bounds.size.width, y: 0, width: self.mainLb.frame.size.width, height: UIScreen.main.bounds.size.width)
        self.mainLb.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi/2)
    }
    
    func setSpeed(speed: CGFloat) {
        
    }
    
    func setContentFont(font: UIFont) {
        self.mainLb.font = font
    }
    
    func setContentColor(color: UIColor) {
        self.mainLb.textColor = color;
    }
    
    func showSetting() {
        // 显示设置视图
        
    }
    
    
}


// MARK: - 设置页面回调


// MARK: - 输入框代理
extension ViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.stopAnim()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.setContentText(text: self.textFiled.text!)
            self.isAnimStop = false
            self.startAnim()
        }
    }
}

// MARK: - 弹幕滚动
extension ViewController {
    func startAnim() {
        if self.isAnimStop {
            return
        }
        let totalH = self.mainView.frame.size.height + UIScreen.main.bounds.height
        let duration: TimeInterval = TimeInterval(totalH / (UIScreen.main.bounds.height/3))
        
        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            self.mainView.transform = CGAffineTransform.init(translationX: 0, y: -totalH)
        }) { (flag) in
            self.mainView.transform = CGAffineTransform.identity
            self.mainLb.transform = CGAffineTransform.identity
            self.startAnim()
        }
    }
    
    func stopAnim() {
        self.isAnimStop = true
        self.mainLb.layer.removeAllAnimations()
        self.mainView.layer.removeAllAnimations()
    }
}

// MARK: - 背景动画
extension ViewController {
    func startBgAnim() {
        guard let path = Bundle.main.path(forResource: "1.GIF", ofType: nil) else { return }
        guard let data = NSData(contentsOfFile: path) else { return }
        guard let imageSource = CGImageSourceCreateWithData(data, nil) else { return }
        let imageCount = CGImageSourceGetCount(imageSource)
        
        var images = [UIImage]()
        var totalDuration : TimeInterval = 0
        for i in 0..<imageCount {
            guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else { continue }
            let image = UIImage(cgImage: cgImage)
            if i == 0 {
                self.mainBg.image = image
            }
            images.append(image)
            guard let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) else { continue }
            guard let gifDict = (properties as NSDictionary)[kCGImagePropertyGIFDictionary] as? NSDictionary else { continue }
            guard let frameDuration = gifDict[kCGImagePropertyGIFDelayTime] as? NSNumber else { continue }
            totalDuration += frameDuration.doubleValue
        }
        
        self.mainBg.animationImages = images
        self.mainBg.animationDuration = totalDuration
        self.mainBg.animationRepeatCount = 0
        self.mainBg.startAnimating()
    }
}
