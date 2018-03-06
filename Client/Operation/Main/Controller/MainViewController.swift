//
//  MainViewController.swift
//  Client
//
//  Created by Hengzhan on 2018/2/6.
//  Copyright © 2018年 Hengzhan. All rights reserved.
//

import UIKit
import SDWebImage

class MainViewController: BaseViewController {
    
    @IBOutlet weak var headerVi: UIView!
    @IBOutlet weak var contentTableVi: UITableView!
    @IBOutlet weak var contentCollectionVi: UICollectionView!
    fileprivate lazy var bannerVi:InfiniteCircularView = {
        let vi = InfiniteCircularView()
        vi.frame = CGRect(x: 0, y: 0, width: Screen.Width, height: 165)
        return vi
    }()
    fileprivate let mainService = MainService.shared
    fileprivate lazy var mallParam:[String:Any] = {
        var par = [String:Any]()
        par["PageIndex"] = "1"
        par["QueryLimit"] = "3"
        return par
    }()
    fileprivate lazy var banners = [BannerModel]()
    fileprivate lazy var products = [ProductModel]()
    fileprivate lazy var videos = [VideoModel]()
    fileprivate lazy var photoes = [PhotoModel]()
    fileprivate var consulteType = "video"
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
        initView()
        loadData()
    }
    
    //MARK: 初始化导航栏
    fileprivate func initNav() {
        super.setUpBackButton()
        super.setUpNavTitle(title: "恒瑞健康")
    }
    //MARK: 初始化视图
    fileprivate func initView() {
        contentCollectionVi.collectionViewLayout = MainFlowLayout()
        contentCollectionVi.register(UINib(nibName: "MainCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionCellID")
        contentTableVi.register(UINib(nibName: "MainTableCell", bundle: nil), forCellReuseIdentifier: "MainTableCellID")
        headerVi.addSubview(bannerVi)
        bannerVi.didClickBannerImageClosure = {(vi,index) -> Void in
            self.didClickBanner(index: index)
        }
    }
    //MARK: 加载数据
    fileprivate func loadData(){
        mainService.loadBanner(param: ["PageIndex":"1","QueryLimit":"10","Category":"APP商城首页"]) { (data,mods) in
            if let urls = data as? [String] {
                self.bannerVi.urlStrs = urls
                self.bannerVi.reloadInfiniteCircularView()
            }
            if let banns = mods as? [BannerModel]{
                self.banners = banns
            }
        }
        mainService.loadMallType(param: ["PageIndex":"1","QueryLimit":"1"]) { (data) in
            if let Id = data as? String {
                self.mallParam["CategoryId"] = Id
                self.loadMallData()
            }
        }
        loadVideoData()
    }
    //MARK: 加载恒瑞优选数据
    fileprivate func loadMallData(){
        mainService.loadMallProduct(param: mallParam) { (data) in
            if let prods = data as? [ProductModel]{
                self.products = prods
                self.contentCollectionVi.reloadData()
            }
        }
    }
    //MARK: 加载视频数据
    fileprivate func loadVideoData(){
        mainService.loadVideo(param: ["PageIndex":"1","QueryLimit":"10"]) { (data) in
            if let vids = data as? [VideoModel] {
                self.videos = vids
                self.contentTableVi.reloadData()
            }
        }
    }
    //MARK: 加载图片数据
    fileprivate func loadPhotoData(){
        mainService.loadPhoto(param: ["PageIndex":"1","QueryLimit":"10"]) { (data) in
            if let phoes = data as? [PhotoModel] {
                self.photoes = phoes
                self.contentTableVi.reloadData()
            }
        }
    }
}
//MARK: 扩展
extension MainViewController {
    fileprivate func didClickBanner(index:Int){
        let banner = banners[index]
        if banner.ContentUrl.contains("Mobile/System/Video") { //视频咨询详情页
            
        }else if banner.ContentUrl.contains("Mobile/System/Article") { //图文咨询详情页
            
        }else {
            
        }
    }
}
//MARK: UICollectionViewDataSource
extension MainViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionCellID", for: indexPath) as! MainCollectionCell
        let product = products[indexPath.item]
        let url = URL(string: product.SmallImageUrl)
        if url != nil {
            cell.conImageVi.sd_setImage(with: url!, placeholderImage: UIImage(named: ""))
        }
        cell.nameLab.text = product.Name
        cell.priceLab.text = "￥\(product.UnitPrice)元" 
        return cell
    }
}
//MARK: UITableViewDataSource
extension MainViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if consulteType == "video" {
            return videos.count
        }else{
            return photoes.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableCellID") as! MainTableCell
        
        if consulteType == "video" {
            let video = videos[indexPath.row]
            let url = URL(string: video.SmallImageUrl)
            if url == nil {
                cell.conImageVi.image = UIImage(named: "main_play")
            }else{
                cell.conImageVi.sd_setImage(with: url, placeholderImage: UIImage(named: "main_play"))
            }
            cell.titleLab.text = video.Title
            cell.isHideVi.isHidden = false
        }else{
            let photo = photoes[indexPath.row]
            let url = URL(string: photo.SmallImageUrl)
            if url == nil {
                cell.conImageVi.image = UIImage(named: "main_play")
            }else{
                cell.conImageVi.sd_setImage(with: url, placeholderImage: UIImage(named: "main_play"))
            }
            cell.titleLab.text = photo.Title
            cell.isHideVi.isHidden = true
        }
        
        return cell
    }
}

