//
//  MyOfflineHeaderCell.swift
//  Swift_test
//
//  Created by yytmzys on 2018/12/6.
//  Copyright © 2018 yytmzys. All rights reserved.
//

import UIKit


class MyOfflineHeaderCell: UITableViewCell {
  
  var pushSongHandler:((_ index: Int)->())?
  var playSongHandler:((_ index: Int)->())?
  
  fileprivate var myItmeView1:MyOfflineHeaderItemView? = nil
  fileprivate var myItmeView2:MyOfflineHeaderItemView? = nil
  
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


extension MyOfflineHeaderCell {
  
  func configure() {
    myItmeView1!.configure()
    myItmeView2!.configure()
  }
  
}


fileprivate extension MyOfflineHeaderCell {
  
  func setup() {
    
    for index in 0...1 {
      let myItmeView = MyOfflineHeaderItemView(frame: .zero)
      self.addSubview(myItmeView)
      
      myItmeView.pushSongHandler = {
        if let handler =  self.pushSongHandler {
          handler(index)
        }
      }
      myItmeView.playSongHandler = {
        if let handler =  self.playSongHandler {
          handler(index)
        }
      }
      
      myItmeView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
      myItmeView.autoPinEdge(toSuperviewEdge: .top, withInset: 26 + CGFloat(index * (80 + 18)))
      myItmeView.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
      myItmeView.autoSetDimension(.height, toSize: 80)
      
      if index == 0 {
        myItmeView1 = myItmeView
      }else {
        myItmeView2 = myItmeView
      }
    }
  }
  
  
}

