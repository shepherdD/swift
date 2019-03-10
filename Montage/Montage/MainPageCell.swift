//
//  MainPageCell.swift
//  Montage
//
//  Created by wudi on 2019/3/9.
//  Copyright © 2019 BigGun. All rights reserved.
//

import UIKit

class MainPageCell: UICollectionViewCell {

    @IBOutlet weak var titleLb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = true;
    }
}
