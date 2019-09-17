//
//  KPNewsAddFriendInviteCell.swift
//  Keep
//
//  Created by 舒明明 on 17/4/16.
//  Copyright © 2017年 Damon. All rights reserved.
//

import UIKit

protocol KPNewsAddFriendInviteCellDelegate: NSObjectProtocol {
    func addFriendInviteCell(_ bottom:KPNewsAddFriendInviteCell, button:UIButton)
}

class KPNewsAddFriendInviteCell: UITableViewCell {

    weak var delegate: KPNewsAddFriendInviteCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white

        setupUI()
    }
    
    fileprivate func setupUI() {
        
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
    
    
//    Address Book
    @objc func buttonClick(_ button:UIButton) {
        
        delegate?.addFriendInviteCell(self, button: button)
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }

}
