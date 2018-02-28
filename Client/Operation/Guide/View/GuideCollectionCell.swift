//
//  GuideCollectionCell.swift
//  Client
//
//  Created by Hengzhan on 2018/2/2.
//  Copyright © 2018年 Hengzhan. All rights reserved.
//

import UIKit

protocol GuideCollectionCellDelegate:NSObjectProtocol {
    
    func startBtnClick(btn:UIButton)
    
}

class GuideCollectionCell: UICollectionViewCell {
    
    weak var delegate:GuideCollectionCellDelegate?
    
    @IBOutlet weak var conImageVi: UIImageView!
    
    @IBOutlet weak var startBtn: UIButton!{
        didSet{
            startBtn.layer.borderWidth = 1
            startBtn.layer.borderColor = UIColor.white.cgColor
            startBtn.layer.cornerRadius = 3
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func startButtonClick(_ sender: UIButton) {
        delegate?.startBtnClick(btn: sender);
    }
    
    
}


class GuideCollectionLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        itemSize = CGSize(width: Screen.Width, height: Screen.Height)
        scrollDirection = .horizontal
    }
}



