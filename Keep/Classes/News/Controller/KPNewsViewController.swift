//
//  KPNewsViewController.swift
//  Keep
//
//  Created by Damon on 17/3/8.
//  Copyright © 2017年 Damon. All rights reserved.
//

import UIKit
import MJRefresh
//import RealmSwift
//import SQLite

let KPNewsHotCollectionCellIdentifier = "KPNewsHotCollectionCellIdentifier"

let KPNewsHotHeadViewIdentifier = "KPNewsHotHeadViewIdentifier"

class KPNewsViewController: KPBaseViewController {

    fileprivate var hotItems = [KPNewsHotItem]()
    fileprivate var followItems = [KPHotDetailItem]()
    fileprivate var cityItems = [KPHotDetailItem]()

    var scrollView: UIScrollView?
    
    var hotCollectionView: UICollectionView?
    var refreshControl = UIRefreshControl()
    let footer = MJRefreshAutoNormalFooter()
    
    var followTableView: UITableView?
    var followRefreshControl = UIRefreshControl()
    let followFooter = MJRefreshAutoNormalFooter()
    
    var cityTableView: UITableView?
    var cityRefreshControl = UIRefreshControl()
    let cityFooter = MJRefreshAutoNormalFooter()
    
    var lastID : String?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        loadHotData()
        
        loadFollowsData()

        loadCityData()

    }
    
    fileprivate func setupUI() {
    
        view.backgroundColor = KPBg()
        self.automaticallyAdjustsScrollViewInsets = false;
        navigationItem.titleView = segmentView
        
        let rightItem = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(rightItemClick))
        
        let leftItem = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(leftItemClick))
        
        navigationItem.leftBarButtonItem = leftItem
        navigationItem.rightBarButtonItem = rightItem
    
        // UICollectionView
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.bounds.width - 3 * 15)/2.0, height: (view.bounds.width - 3 * 15)/2.0 + 80)
        
        let hotCollectionView = UICollectionView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size:CGSize(width: view.bounds.width, height: (view.bounds.height - 44))), collectionViewLayout: layout)
        
        hotCollectionView.register(KPNewsHotCollectionCell.self, forCellWithReuseIdentifier: KPNewsHotCollectionCellIdentifier)
        hotCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: KPNewsHotHeadViewIdentifier)
        
        hotCollectionView.delegate = self
        hotCollectionView.dataSource = self
        hotCollectionView.backgroundColor = UIColor.white
        self.hotCollectionView = hotCollectionView
        
        refreshControl.addTarget(self, action: #selector(loadHotData), for: .valueChanged)
        self.hotCollectionView?.addSubview(refreshControl)
        
        footer.setRefreshingTarget(self, refreshingAction: #selector(KPNewsViewController.loadHotData))
        self.hotCollectionView?.mj_footer = footer
        
        /// 关注
        let followTableView = UITableView(frame: CGRect(x: view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height - 44), style: .plain)
        followTableView.backgroundColor = KPTable()
        followTableView.register(KPNewsDetailAuthorCell.self, forCellReuseIdentifier: KPNewsDetailAuthorCellIdentifier)
        
        followTableView.tableFooterView = UIView()
        followTableView.delegate = self
        followTableView.dataSource = self
        self.followTableView = followTableView
        followRefreshControl.addTarget(self, action: #selector(loadFollowsData), for: .valueChanged)
        self.followTableView?.addSubview(followRefreshControl)
        
        followFooter.setRefreshingTarget(self, refreshingAction: #selector(KPNewsViewController.loadFollowsData))
        self.followTableView?.mj_footer = followFooter
        
        
        /// 同城
        let cityTableView = UITableView(frame: CGRect(x:view.bounds.width * 2, y: 0, width: view.bounds.width, height: view.bounds.height - 44), style: .plain)
        cityTableView.backgroundColor = KPTable()
        cityTableView.register(KPNewsDetailAuthorCell.self, forCellReuseIdentifier: KPNewsDetailAuthorCellIdentifier)
        cityTableView.tableFooterView = UIView()
        cityTableView.delegate = self
        cityTableView.dataSource = self
        self.cityTableView = cityTableView
        
        cityRefreshControl.addTarget(self, action: #selector(loadCityData), for: .valueChanged)
        self.cityTableView?.addSubview(cityRefreshControl)
        
        cityFooter.setRefreshingTarget(self, refreshingAction: #selector(KPNewsViewController.loadCityData))
        self.cityTableView?.mj_footer = cityFooter
        
        let scrollView = UIScrollView(frame: CGRect(x:0, y: 64, width: view.bounds.width, height: view.bounds.height - 64))
        scrollView.contentSize = CGSize(width: view.bounds.width * 3, height: view.bounds.height - 44)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.delegate = self
        self.scrollView = scrollView
        
        scrollView.addSubview(hotCollectionView)

        scrollView.addSubview(followTableView)

        scrollView.addSubview(cityTableView)
        
        self.view.addSubview(scrollView)
    }
    
    @objc fileprivate func loadHotData() {
        
//        KPNetworkTool.shareNetworkTool.loadNewsHotData(last: nil) {[weak self]
//        
//            (data) in
//            
//            self?.lastID = data.1
//            
//            if self?.lastID != nil {
//            
//                self?.hotItems.append(contentsOf: data.0)
//                self?.hotCollectionView?.mj_footer.endRefreshing()
//                
//            } else {
//                self?.hotItems = data.0
//            }
//            
//            if (self?.refreshControl.isRefreshing)! {
//            
//                self?.refreshControl.endRefreshing()
//            }
//            
//            self?.hotCollectionView?.reloadData()
//        }
    }
    
    @objc fileprivate func loadFollowsData() {

//        KPNetworkTool.shareNetworkTool.loadNewsFollowListData(last: lastID) { [weak self]
//
//            (data) in
//
//            self?.lastID = data.1
//
//            if self?.lastID != nil {
//
//                self?.followItems.append(contentsOf: data.0)
//                self?.followTableView?.mj_footer.endRefreshing()
//
//            } else {
//                self?.followItems = data.0
//            }
//
//            if (self?.followRefreshControl.isRefreshing)! {
//
//                self?.followRefreshControl.endRefreshing()
//            }
//
//            self?.followTableView?.reloadData()
//        }
        
    }
    
    @objc fileprivate func loadCityData() {
        
        
    }
    
    fileprivate lazy var hotImageView: UIImageView = {
    
        let hotImageView = UIImageView()
        
        hotImageView.isUserInteractionEnabled = true
        let ges = UITapGestureRecognizer(target: self, action: #selector(clickHotVideo))
        hotImageView.addGestureRecognizer(ges)
        
        let urlStr = "http://static1.keepcdn.com/picture/2017/04/18/09/5fc733ac81925e13e031b8d8be0acbd282ee1465_1920x1080.jpg"
        hotImageView.kf.setImage(with: URL(string: urlStr), placeholder: nil)
        let photoSize = urlStr.getImageViewSize()
        hotImageView.frame = CGRect(x: 0, y: 0, width: photoSize.width, height: photoSize.height)
        
        let hotLabel = UILabel()
        hotLabel.text = "Hot Video"
        hotLabel.frame = CGRect(x: (view.bounds.width - 100)/2.0, y: 60, width: 100, height: 20)
        hotLabel.font = UIFont.boldSystemFont(ofSize: 17)
        hotLabel.textColor = UIColor.white
        hotLabel.textAlignment = .center
        hotImageView.addSubview(hotLabel)

        let lineView = UIView()
        lineView.backgroundColor = UIColor.white
        lineView.frame = CGRect(x: (view.bounds.width - 30)/2.0, y: 85, width: 30, height: 1.5)
        hotImageView.addSubview(lineView)
        
        let todayHotLabel = UILabel()
        todayHotLabel.frame = CGRect(x: (view.bounds.width - 200)/2.0, y: 105, width: 200, height: 20)
        todayHotLabel.text = "今日热门视频"
        todayHotLabel.textColor = UIColor.white
        todayHotLabel.font = UIFont.boldSystemFont(ofSize: 16)
        let attributedString = NSMutableAttributedString(string: todayHotLabel.text!, attributes: [NSAttributedString.Key.kern: (10)])
        let style = NSMutableParagraphStyle()
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: (todayHotLabel.text?.count)!))
        todayHotLabel.attributedText = attributedString
        todayHotLabel.textAlignment = .center

        hotImageView.addSubview(todayHotLabel)

        let videoImageView = UIImageView()
        videoImageView.image = UIImage(named: "video_play_samll")
        videoImageView.frame = CGRect(x: (view.bounds.width - 40)/2.0, y: 140, width: 40, height: 40)
        hotImageView.addSubview(videoImageView)
        
        return hotImageView
    }()
    
    
    @objc fileprivate func clickHotVideo() {
    
        let hotVideoVC = KPNewsHotVideoController()
        self.navigationController?.pushViewController(hotVideoVC, animated: true)
    }
    
    fileprivate lazy var segmentView: KPSegmentView = {
        let segmentView = KPSegmentView(frame: CGRect(x: 0, y: 0, width: 0, height: 44), ["热门","关注","同城"])
        segmentView.delegate = self
        return segmentView
    }()
    
    
    @objc func rightItemClick() {
        let publishVC = KPPublishViewController()
        let nav = KPNavigationController.init(rootViewController: publishVC)
        self.present(nav, animated: true, completion:
            nil)
    }
    
    @objc func leftItemClick() {
        let addFriendVC = KPAddFriendController()
        navigationController?.pushViewController(addFriendVC, animated: true)
    }
}

extension KPNewsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let hotDetailVC = KPHotDetailController()
        
        hotDetailVC.userID = hotItems[indexPath.row].id
        
        self.navigationController?.pushViewController(hotDetailVC, animated: true)
        
        let hot = hotItems[indexPath.row]
        print(hot.content ?? "无内容")
    }
}

extension KPNewsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
    
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return hotItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KPNewsHotCollectionCellIdentifier, for: indexPath) as! KPNewsHotCollectionCell
        
        cell.hotItem = hotItems[indexPath.row]
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: KPNewsHotHeadViewIdentifier, for: indexPath as IndexPath)
            
            headerView.addSubview(hotImageView)
            return headerView
            
        } else {
            
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: KPNewsHotHeadViewIdentifier, for: indexPath as IndexPath)
            footerView.addSubview(hotImageView)

            return footerView
        }
    }
}

extension KPNewsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
        return UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    
        let urlStr = "http://static1.keepcdn.com/picture/2017/04/18/09/5fc733ac81925e13e031b8d8be0acbd282ee1465_1920x1080.jpg"
        return urlStr.getImageViewSize()
    }
}

extension KPNewsViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.section == 1 {
            
        }
    }
}

extension KPNewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return followItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: KPNewsDetailAuthorCellIdentifier) as! KPNewsDetailAuthorCell
        cell.hotDetailItem = followItems[indexPath.row]
        cell.bottomView.delegate = self
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return KPNewsDetailAuthorCell.heightOfAuthorCell(followItems[indexPath.row])
    }
    
}

extension KPNewsViewController: KPSegmentViewDelegate {

    func segmentView(_ segmentView: KPSegmentView, button: UIButton) {
        
        scrollView?.setContentOffset(CGPoint(x: button.tag * Int(view.bounds.width), y: 0), animated: true)
    }
}

extension KPNewsViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
        segmentView.offsetRate = scrollView.contentOffset.x / view.bounds.width
    }
}

extension KPNewsViewController: KPNewsHotBottomButtonDelegate {

    func newsHotBottomButton(_ bottomView:KPNewsHotBottomView, button:UIButton) {
    
    }
}

