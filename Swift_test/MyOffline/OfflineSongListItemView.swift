//
//  OfflineSongListItemView.swift
//  Swift_test
//
//  Created by yytmzys on 2018/12/7.
//  Copyright © 2018 yytmzys. All rights reserved.
//

import UIKit

class OfflineSongListItemView: UIView {

  fileprivate let listImageView = UIImageView(frame: .zero)
  fileprivate let listNameLabel = UILabel(frame: .zero)
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}


fileprivate extension OfflineSongListItemView {
  func setup() {
    
    listImageView.backgroundColor = UIColor.orange
    self.addSubview(listImageView)
    listImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 25)
    listImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
    listImageView.autoSetDimensions(to: CGSize(width: 98, height: 60))
    
    
    
    listNameLabel.text = "歌单名字"
    listNameLabel.font = UIFont(name: "PingFangSC-Regular", size: 14)
    listNameLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    self.addSubview(listNameLabel)
    listNameLabel.autoPinEdge(.left, to: .right, of: listImageView, withOffset: 20)
    listNameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
    listNameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 25)
    listNameLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 40)
  }
  
}

