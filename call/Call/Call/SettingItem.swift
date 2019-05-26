//
//  SettingItem.swift
//  Call
//
//  Created by wudi on 2019/5/26.
//  Copyright © 2019 BigGun. All rights reserved.
//

import UIKit

enum showType: Int {
    case defaultType = 0
    case switchType = 1
}

class SettingItem: UIView {

    var style: showType
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.white;
        return label
    }()

    private lazy var subView: UIScrollView = {
        let view = UIScrollView.init()
        view.isHidden = true
        return view
    }()
    
    private lazy var switchBtn: UISwitch = {
        let switchBtn = UISwitch.init()
        switchBtn.isHidden = true
        return switchBtn
    }()
    
    init(frame: CGRect, withStyle: showType) {
        style = withStyle
        super.init(frame: frame)
        self.configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        switch style {
        case .switchType:
            self.addSubview(self.titleLabel)
            self.titleLabel.snp.makeConstraints { (make) in
                make.top.left.equalToSuperview().inset(UIEdgeInsets.init(top: 0, left: 4, bottom: 0, right: 0))
                make.height.equalTo(32)
            }
            
            self.addSubview(self.switchBtn)
            self.switchBtn.snp.makeConstraints { (make) in
                make.top.right.equalToSuperview()
                make.width.equalTo(51)
                make.height.equalTo(32)
            }
            
            self.switchBtn.isHidden = false
            break
        default:
            self.addSubview(self.titleLabel)
            self.titleLabel.snp.makeConstraints { (make) in
                make.top.left.equalToSuperview().inset(UIEdgeInsets.init(top: 0, left: 14, bottom: 0, right: 0))
            }
            
            self.addSubview(self.subView)
            self.subView.snp.makeConstraints { (make) in
                make.top.equalTo(self.titleLabel.snp_bottomMargin).offset(12)
                make.left.equalToSuperview().offset(14)
                make.width.equalTo(self.bounds.size.width - 14)
                make.height.equalTo(50)
            }
            
            self.subView.isHidden = false
            break
        }
    }
    
    func configData(title: String, dataSource: NSDictionary) {
        self.titleLabel.text = title
    }
    
    func configData(title: String) {
        self.titleLabel.text = title;
    }
}
