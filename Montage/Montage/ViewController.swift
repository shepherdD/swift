//
//  ViewController.swift
//  Montage
//
//  Created by wudi on 2019/3/9.
//  Copyright © 2019 BigGun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registCell()
        self.initData()
    }

    func registCell() {
        let layout = UICollectionViewFlowLayout.init()
        let itemWidth = (UIScreen.main.bounds.size.width - 32 - 15)/2
        layout.itemSize = CGSize.init(width: itemWidth, height: itemWidth)
        layout.minimumLineSpacing = 15;
        layout.minimumInteritemSpacing = 15;
        self.collectionView.collectionViewLayout = layout
        self.collectionView.register(UINib.init(nibName: "MainPageCell", bundle: nil), forCellWithReuseIdentifier: "MainPageCellID")
    }
    
    func initData() {
        dataSource.append("视频去水印")
        dataSource.append("视频加水印")
        dataSource.append("视频变速")
        dataSource.append("视频倒放")
        dataSource.append("视频压缩")
        dataSource.append("视频换封面")
    }   
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MainPageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainPageCellID", for: indexPath) as! MainPageCell
        let title = self.dataSource[indexPath.row]
        cell.titleLb.text = title
        return cell;
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击了"+self.dataSource[indexPath.row])
    }
}

