//
//  OfflineSongListCell.swift
//  Swift_test
//
//  Created by yytmzys on 2018/12/5.
//  Copyright © 2018 yytmzys. All rights reserved.
//

import UIKit

class OfflineSongListCell: UITableViewCell {
  
  var moreSongListHandler:(()->())?
  
  fileprivate var itemView1:OfflineSongListItemView? = nil
  fileprivate var itemView2:OfflineSongListItemView? = nil
  fileprivate let moreView = UIView(frame: .zero)
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}


extension OfflineSongListCell {
  
  func configure(_ array: Array<Any>) {
    print("array.count == \(array.count)")
    if array.count > 1 {
      itemView1?.isHidden = false
    }
    
    if array.count > 2 {
      itemView2?.isHidden = false
    }
    
    if array.count > 3 {      
      moreView.isHidden = false
    }
  }
  
}


fileprivate extension OfflineSongListCell {
  
  func setup() {
    
    let titleView = OfflineTitleView(frame: .zero)
    titleView.configure(title: "离线歌单")
    self.addSubview(titleView)
    titleView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
    titleView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
    titleView.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
    titleView.autoSetDimension(.height, toSize: 101)
    
    
    for index in 0...2 {
      let itemView = OfflineSongListItemView(frame: .zero)
      self.addSubview(itemView)
      
      itemView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
      itemView.autoPinEdge(.top, to: .bottom, of: titleView, withOffset: 25 + CGFloat(80 * index))
      itemView.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
      titleView.autoSetDimension(.height, toSize: 80)
      
      if index == 1 {
        itemView1 = itemView
        itemView1?.isHidden = true
      } else if index == 2 {
        itemView2 = itemView
        itemView2?.isHidden = true
      }
    }
    
    moreView.isHidden = true
    self.addSubview(moreView)
    moreView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
    moreView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
    moreView.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
    moreView.autoSetDimension(.height, toSize: 35)
    
    
    let moreButton = UIButton(type: .custom)
    moreButton.frame = CGRect(x: 0, y: 0, width: 110, height: 35)
    moreButton.setTitle("查看更多", for: .normal)
    moreButton.setTitleColor(UIColor.green, for: .normal) // #0EDDAB
    moreButton.titleLabel!.font = UIFont(name: "PingFangSC-Regular", size: 14)
    moreButton.addTarget(self, action: #selector(moreHandler), for: .touchUpInside)
    moreButton.backgroundColor = UIColor.white
    moreButton.backgroundColor = UIColor.white
    moreButton.layer.shadowColor = UIColor.red.cgColor // #C3C3C3
    moreButton.layer.shadowOpacity = 1.0
    moreButton.layer.shadowOffset = CGSize(width: 0, height: 5)
    moreButton.layer.shadowRadius = 17
    moreButton.layer.cornerRadius = 35/2
    moreView.addSubview(moreButton)
    
    moreButton.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
    moreButton.autoAlignAxis(toSuperviewAxis: .vertical)
    moreButton.autoSetDimensions(to: CGSize(width: 110, height: 35))
    
  }
  
  @objc func moreHandler() {
    if let handler = moreSongListHandler {
      handler()
    }
  }
  
}
