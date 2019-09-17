//
//  KPMineTabButtonCell.swift
//  Keep
//
//  Created by Damon on 17/3/9.
//  Copyright © 2017年 Damon. All rights reserved.
//

import UIKit
import SnapKit

protocol KPMineTabButtonCellDelegate: NSObjectProtocol {
    func tabButtonmCell(_ bottom:KPMineTabButtonCell, button:UIButton)
}

class KPMineTabButtonCell: UITableViewCell {

    weak var delegate: KPMineTabButtonCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white

        setupUI()
    }
    
    fileprivate func setupUI() {
    
        let buttonW = (SCREENW - 20*2 - 60*4)/3.0
        
        addSubview(historyButton)
        
        addSubview(collectionButton)
        
        addSubview(dataButton)
        
        addSubview(sportsButton)
        
        historyButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.top.equalTo(15)
            make.left.equalTo(20)
        }
        
        collectionButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.top.equalTo(historyButton.snp.top)
            make.left.equalTo(historyButton.snp.right).offset(buttonW)
        }
        
        dataButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.top.equalTo(historyButton.snp.top)
            make.left.equalTo(collectionButton.snp.right).offset(buttonW)

        }
        
        sportsButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.top.equalTo(historyButton.snp.top)
            make.left.equalTo(dataButton.snp.right).offset(buttonW)
        }
        
        
    }
    // 训练历史
    lazy var historyButton: KPMineTabButton = {
        let historyButton = KPMineTabButton()
        historyButton.tag = 1
        historyButton.setImage(UIImage(named: "personal_history"), for: UIControl.State())
        historyButton.setTitle("训练历史", for: UIControl.State())
        historyButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        return historyButton
    }()
    
    // 我的收藏
    lazy var collectionButton: KPMineTabButton = {
        let collectionButton = KPMineTabButton()
        collectionButton.tag = 2
        collectionButton.setImage(UIImage(named: "personal_body_date"), for: UIControl.State())
        collectionButton.setTitle("我的收藏", for: UIControl.State())
        collectionButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        return collectionButton
    }()
    
    // 身体数据
    lazy var dataButton: KPMineTabButton = {
        let dataButton = KPMineTabButton()
        dataButton.tag = 3
        dataButton.setImage(UIImage(named: "personal_body_date"), for: UIControl.State())
        dataButton.setTitle("身体数据", for: UIControl.State())
        dataButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        return dataButton
    }()
    
    // 运动能力
    lazy var sportsButton: KPMineTabButton = {
        let sportsButton = KPMineTabButton()
        sportsButton.tag = 4
        sportsButton.setImage(UIImage(named: "personal_history"), for: UIControl.State())
        sportsButton.setTitle("运动能力", for: UIControl.State())
        sportsButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        return sportsButton
    }()
    
    @objc func buttonClick(_ button:UIButton) {
    
        delegate?.tabButtonmCell(self, button: button)
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
}
