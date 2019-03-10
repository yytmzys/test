//
//  OfflineSongRecordCell.swift
//  Swift_test
//
//  Created by yytmzys on 2018/12/5.
//  Copyright © 2018 yytmzys. All rights reserved.
//

import UIKit

class OfflineSongRecordCell: UITableViewCell {

  var recordImageHandler:((_ index: Int)->())?
  var recordPalyHandler: ((_ index: Int)->())?
  var moreHandler: (()->())?
  fileprivate var myItmeView1:OfflineSongRecordItemView? = nil
  fileprivate var myItmeView2:OfflineSongRecordItemView? = nil
  
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


extension OfflineSongRecordCell {
  
  func configure(songRecordArray: Array<Any>) {
    myItmeView1?.configure()
    myItmeView2?.configure()
  }
}


fileprivate extension OfflineSongRecordCell {
  func setup() {
    
    let titleView = OfflineTitleView(frame: .zero)    
    titleView.configure(title: "离线唱片")
    titleView.configure(buttonTitle: "更多")
    titleView.rightHandler = {
      if let handler = self.moreHandler {
        handler()
      }
    }
    self.addSubview(titleView)
    titleView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
    titleView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
    titleView.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
    titleView.autoSetDimension(.height, toSize: 101)
    
    
    let wid = (UIScreen.main.bounds.size.width - 67) / 2
    for index in 0...1 {
      
      let myItmeView = OfflineSongRecordItemView(frame: .zero)
      self.addSubview(myItmeView)
      
      myItmeView.autoPinEdge(toSuperviewEdge: .left, withInset: 25 + (wid + 17) * CGFloat(index) )
      myItmeView.autoPinEdge(.top, to: .bottom, of: titleView, withOffset: 0)
      myItmeView.autoSetDimensions(to: CGSize(width: wid, height: wid + 63))
      
      myItmeView.ietmRecordPushHandler = {
        if let handler =  self.recordImageHandler {
          handler(index)
        }
      }
      
      myItmeView.itemRecordPalyHandler = {
        if let handler =  self.recordPalyHandler {
          handler(index)
        }
      }
      
      if index == 0 {
        myItmeView1 = myItmeView
      }else {
        myItmeView2 = myItmeView
      }
    }
    
  }
  
}
