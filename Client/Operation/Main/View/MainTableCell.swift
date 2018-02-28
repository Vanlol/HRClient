//
//  MainTableCell.swift
//  Client
//
//  Created by Hengzhan on 2018/2/8.
//  Copyright © 2018年 Hengzhan. All rights reserved.
//

import UIKit

class MainTableCell: UITableViewCell {
    
    @IBOutlet weak var conImageVi: UIImageView!
    @IBOutlet weak var isHideVi: UIView!
    @IBOutlet weak var titleLab: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
