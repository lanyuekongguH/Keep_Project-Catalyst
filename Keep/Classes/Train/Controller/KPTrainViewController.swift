//
//  KPTrainViewController.swift
//  Keep
//
//  Created by Damon on 17/3/8.
//  Copyright © 2017年 Damon. All rights reserved.
//

import UIKit
import SwiftyJSON
import SWTableViewCell

enum TrainType : Int {
    
    case today
    
    case fitness
    
    case run
    
    case cycling
}

let KPTrainPlanListCellIdentifier = "KPTrainPlanListCellIdentifier"

class KPTrainViewController: UIViewController {

    var tableView: UITableView?

    fileprivate var todayTableView: UITableView?
    fileprivate var fitnessTableView: UITableView?
    fileprivate var runTableView: UITableView?
    fileprivate var cyclingView: KPTrainCyclingView?
    
    fileprivate var todayItems = [KPNewsHotItem]()
    fileprivate var fitnessItems = [KPDiscoveryTrainItem]()
    fileprivate var runItems = [KPDietItem]()
    fileprivate var cyclingItems = [KPHotDetailItem]()
    
    fileprivate var scrollView: UIScrollView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        navigationItem.titleView = titleView

        let rightItem = UIBarButtonItem(image: UIImage(named: "icon_run_sign"), style: .plain, target: self, action: #selector(rightItemClick))
        navigationItem.rightBarButtonItem = rightItem
        
        setupUI()
        
        button.setTitle("开始", for: UIControl.State())
        button.setTitleColor(UIColor.black, for: UIControl.State())
        button.frame = CGRect.init(x: 100, y: 100, width: 100, height: 100)
        self.view.addSubview(button)
        
        
        #if targetEnvironment(macCatalyst)
        
        print("mac targetEnvironment")
        #endif
        
        
        if #available(iOS 13.0, *) {
            let hover = UIHoverGestureRecognizer(target: self, action: #selector(hovering(_:)))
            button.addGestureRecognizer(hover)
        }
    }
    
    fileprivate lazy var button: UIButton = {
        let button = UIButton()
        return button
    }()
    
    @available(iOS 13.0, *)
    @objc func hovering(_ recognizer: UIHoverGestureRecognizer) {
        switch recognizer.state {
        case .began, .changed:
            button.titleLabel?.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        case .ended:
            button.titleLabel?.textColor = UIColor.black
        default:
            break
        }
    }
    
    @objc fileprivate func buttonClick() {
    
        let lineMapVc = KPTrainMapPathController()
        self.navigationController?.pushViewController(lineMapVc, animated: true)
    }
    
    fileprivate func setupUI() {
        
        view.addSubview(statusBar)

        view.addSubview(tabView)
        
        self.automaticallyAdjustsScrollViewInsets = false;
        
        let scrollView = UIScrollView(frame: view.bounds)

        scrollView.backgroundColor = KPBg()
        scrollView.contentSize = CGSize(width: view.bounds.width * 4, height: view.bounds.height - (80 + 49))
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        view.addSubview(scrollView)
        self.scrollView = scrollView
        
        
        let todayTableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - (80 + 49)), style: .plain)
        todayTableView.backgroundColor = KPGray()
        todayTableView.separatorStyle = .none
        todayTableView.tag = TrainType.today.rawValue
        todayTableView.backgroundColor = KPBg()
        todayTableView.register(UITableViewCell.self, forCellReuseIdentifier: KPTrainPlanListCellIdentifier)
        todayTableView.tableFooterView = UIView()
        todayTableView.delegate = self
        todayTableView.dataSource = self
        scrollView.addSubview(todayTableView)
        self.todayTableView = todayTableView
        
        let fitnessTableView = UITableView(frame: CGRect(x: view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height - (80 + 49)), style: .plain)
        fitnessTableView.backgroundColor = KPLightGray()
        fitnessTableView.separatorStyle = .none
        fitnessTableView.tag = TrainType.fitness.rawValue
        fitnessTableView.backgroundColor = KPBg()
        fitnessTableView.register(UITableViewCell.self, forCellReuseIdentifier: KPTrainPlanListCellIdentifier)
        fitnessTableView.tableFooterView = UIView()
        fitnessTableView.delegate = self
        fitnessTableView.dataSource = self
        scrollView.addSubview(fitnessTableView)
        self.fitnessTableView = fitnessTableView
        
        
        let runTableView = UITableView(frame: CGRect(x: view.bounds.width * 2, y: 0, width: view.bounds.width, height: view.bounds.height - (80 + 49)), style: .plain)
        runTableView.backgroundColor = KPTheme()
        runTableView.separatorStyle = .none
        runTableView.tag = TrainType.run.rawValue
        runTableView.backgroundColor = KPBg()
        runTableView.register(UITableViewCell.self, forCellReuseIdentifier: KPTrainPlanListCellIdentifier)
        runTableView.tableFooterView = UIView()
        runTableView.delegate = self
        runTableView.dataSource = self
        scrollView.addSubview(runTableView)
        self.runTableView = runTableView
        
        let cyclingView = KPTrainCyclingView.init(frame: CGRect(x: view.bounds.width * 3, y: 0, width: view.bounds.width, height: view.bounds.height - (80 + 49)))
        cyclingView.cyclingDelegate = self
        scrollView.addSubview(cyclingView)
        self.cyclingView = cyclingView
    }
    
    @objc func rightItemClick() {
        let runRecordVc = KPTrainRunRecordController()
        let nav = KPNavigationController.init(rootViewController: runRecordVc)
        self.present(nav, animated: true, completion:
        nil)
    }
    
    fileprivate lazy var titleView: UIImageView = {
        let titleView = UIImageView()
        titleView.image = UIImage(named: "keep_logo")
        titleView.frame = CGRect(x: 0, y: 0, width: 50, height: 23)
        return titleView
    }()
    
    fileprivate lazy var statusBar: UIView = {
        let statusBar = UIView()
        statusBar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 20)
        return statusBar
    }()
    
    fileprivate lazy var tabView: KPDiscoveryTabView = {
        let tabView = KPDiscoveryTabView()
        tabView.delegate = self
        tabView.frame = CGRect(x: 0, y: 20, width: view.bounds.width, height: 60)
        return tabView
    }()
}


extension KPTrainViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        switch tableView.tag {
            
            case TrainType.today.rawValue:
                
                print("today")

            case TrainType.fitness.rawValue:
                
                print("fitness")

            case TrainType.run.rawValue:
                
                print("run")
                
            case TrainType.cycling.rawValue:
                
                print("cycling")
                
            default:
                
                print("dddd")
        }
        
        
        if tableView.tag == TrainType.fitness.rawValue {
        
            print("dddd")
        }
        
        if indexPath.section == 1 {
            
        }
    }
}

extension KPTrainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: KPTrainPlanListCellIdentifier)
        cell?.backgroundColor = UIColor.white
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
}


extension KPTrainViewController: SWTableViewCellDelegate {

    func swipeableTableViewCell(_ cell: SWTableViewCell!, didTriggerLeftUtilityButtonWith index: Int) {
    
    }
    
    func swipeableTableViewCell(_ cell: SWTableViewCell!, didTriggerRightUtilityButtonWith index: Int) {
    
    }
    
    func swipeableTableViewCell(_ cell: SWTableViewCell!, scrollingTo state: SWCellState) {
    
    }
    
    func swipeableTableViewCellShouldHideUtilityButtons(onSwipe cell: SWTableViewCell!) -> Bool {
    
        return true
    }
    
    func swipeableTableViewCell(_ cell: SWTableViewCell!, canSwipeTo state: SWCellState) -> Bool {
    
        return true
    }
    
    func swipeableTableViewCellDidEndScrolling(_ cell: SWTableViewCell!) {
    
    }
    
}

extension KPTrainViewController: KPDiscoveryTabButtonDelegate {

    func discoveryTabView(_ tabView: KPDiscoveryTabView, button: UIButton) {
        
    }
}

extension KPTrainViewController: TrainCyclingDelegate {
    
    func TrainCyclingDelegate(_ view: KPTrainCyclingView, button: UIButton) {
        
    }
}



