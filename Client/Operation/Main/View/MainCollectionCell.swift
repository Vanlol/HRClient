//
//  MainCollectionCell.swift
//  Client
//
//  Created by Hengzhan on 2018/2/8.
//  Copyright © 2018年 Hengzhan. All rights reserved.
//

import UIKit

class MainCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var conImageVi: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var priceLab: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

class MainFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
        itemSize = CGSize(width: 175, height: ((collectionView?.bounds.size.height)! - 6))
        scrollDirection = .horizontal
    }
}





