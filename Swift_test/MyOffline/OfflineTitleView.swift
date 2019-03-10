//
//  OfflineTitleCell.swift
//  Swift_test
//
//  Created by yytmzys on 2018/12/5.
//  Copyright © 2018 yytmzys. All rights reserved.
//

import UIKit
import PureLayout

class OfflineTitleView: UIView {
  
  var rightHandler:( ()->() )?
  
  fileprivate let nameLabel = UILabel(frame: .zero)
  fileprivate let moreButton = UIButton(type: .custom)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
}

extension OfflineTitleView {
  
  func configure(title: String) {
    nameLabel.text = title
  }
  
  func configure(buttonTitle: String) {
    if buttonTitle.count > 0 {
      moreButton.isHidden = false
      moreButton.setTitle(buttonTitle, for: .normal)
    }else {
      moreButton.isHidden = true
    }
  }
  
}

fileprivate extension OfflineTitleView {
  
  func setup() {
        
    nameLabel.font = UIFont(name: "PingFangSC-Semibold", size: 20)
    nameLabel.textColor = UIColor.black // #333333
    self.addSubview(nameLabel)
    nameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 26)
    nameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 50)
    nameLabel.autoSetDimensions(to: CGSize(width: 100, height: 26))
  
    
    moreButton.setTitle("更多", for: .normal)
    moreButton.setTitleColor(.black, for: .normal) // #555555
    moreButton.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 14)
    moreButton.isHidden = true
    self.addSubview(moreButton)
    moreButton.addTarget(self, action: #selector(moreRecord), for: .touchUpInside)
    moreButton.autoPinEdge(toSuperviewEdge: .right, withInset: 14)
    moreButton.autoPinEdge(toSuperviewEdge: .top, withInset: 50)
    moreButton.autoSetDimensions(to: CGSize(width: 50, height: 30))
  }
  
  @objc func moreRecord() {
    
    if let handler = rightHandler {
      handler()
    }
  }
  
}
