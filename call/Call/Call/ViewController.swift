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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI();
    }

    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
//        self.startBgAnim()
        self.startAnim()
    }
    
    func initUI() {
        // 初始化父视图
        self.mainView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height))
        self.view.addSubview(self.mainView)
        self.mainView.backgroundColor = UIColor.black
        self.mainBg = UIImageView.init(frame: self.mainView.bounds)
        self.mainView.addSubview(self.mainBg)
        // 初始化跑马灯视图
        self.mainLb = UILabel.init(frame: CGRect.init(x: UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height))
        self.mainView.addSubview(self.mainLb)
        self.setContentFont(font: UIFont.boldSystemFont(ofSize: 180))
        self.setContentText(text: "Call")
        self.setContentColor(color: UIColor.white)
    }
    
    func setContentFont(font: UIFont) {
        self.mainLb.font = font
    }
    
    func setContentText(text: String) {
        var newStr = text
        for _ in 0...20 {
            newStr = newStr + text + " "
        }
        self.mainLb.text = newStr
        self.mainLb.sizeToFit()
        self.mainLb.frame = CGRect.init(x: UIScreen.main.bounds.size.width, y: 0, width: self.mainLb.frame.size.width, height: UIScreen.main.bounds.size.height)
    }
    
    func setContentColor(color: UIColor) {
        self.mainLb.textColor = color;
    }
    
    func startAnim() {
        
        let totalW = self.mainLb.frame.size.width + UIScreen.main.bounds.width
        let duration: TimeInterval = TimeInterval(totalW / (UIScreen.main.bounds.width/3))
        
        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            self.mainLb.transform = CGAffineTransform.init(translationX: -totalW, y: 0)
        }) { (flag) in
            if flag {
                self.mainLb.transform = CGAffineTransform.identity
                self.startAnim()
            }
        }
    }
    
    
    
    func showSetting() {
        // 显示设置视图
    }
}

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
