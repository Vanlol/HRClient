//
//  GuideViewController.swift
//  Client
//
//  Created by Hengzhan on 2018/2/2.
//  Copyright © 2018年 Hengzhan. All rights reserved.
//

import UIKit

class GuideViewController: BaseViewController {

    @IBOutlet weak var contentCollectionVi: UICollectionView!
    
    fileprivate lazy var images:[UIImage] = {
        let arr = [UIImage(named: "guide_1")!,
                   UIImage(named: "guide_2")!,
                   UIImage(named: "guide_3")!,
                   UIImage(named: "guide_4")!,
                   UIImage(named: "guide_5")!]
        return arr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    fileprivate func initView(){
        contentCollectionVi.collectionViewLayout = GuideCollectionLayout()
        contentCollectionVi.register(UINib(nibName: "GuideCollectionCell", bundle: nil), forCellWithReuseIdentifier: "GuideCollectionCellID")
    }
    
}

extension GuideViewController:UICollectionViewDelegate,UICollectionViewDataSource,GuideCollectionCellDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GuideCollectionCellID", for: indexPath) as! GuideCollectionCell
        
        let img = images[indexPath.item]
        cell.conImageVi.image = img
        cell.startBtn.isHidden = indexPath.item == (images.count - 1) ? false : true
        cell.delegate = self
        
        return cell
    }
    
    func startBtnClick(btn: UIButton) {
        let mainVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewControllerID") as! LoginViewController
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: mainVC)
    }
    
}



