//
//  OfflineSongRecordItemView.swift
//  Swift_test
//
//  Created by yytmzys on 2018/12/7.
//  Copyright © 2018 yytmzys. All rights reserved.
//

import UIKit

class OfflineSongRecordItemView: UIView {
  
  var ietmRecordPushHandler:(()->())?
  var itemRecordPalyHandler:(()->())?  
  
  fileprivate let recordButton = UIButton(frame: .zero)
  fileprivate let playButton = UIButton(type: .custom)
  fileprivate let recordNameLabel = UILabel(frame: .zero)
  fileprivate let recordOwnerNameLabel = UILabel(frame: .zero)
  fileprivate let recordReleaseTimeLabel = UILabel(frame: .zero)
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


extension OfflineSongRecordItemView {
  
  public func configure() {
    
//    recordButton.setImage(UIImage(named: "0000"), for: .normal)
    recordNameLabel.text = "未来日记"
    recordOwnerNameLabel.text = "金玟岐"
    recordReleaseTimeLabel.text = "2017.06.30"
  }
  
}


fileprivate extension OfflineSongRecordItemView {
  func setup() {
    
    let wid = (UIScreen.main.bounds.size.width - 67) / 2
    
    recordButton.adjustsImageWhenHighlighted = false
    recordButton.addTarget(self, action: #selector(recordHandler(button:)), for: .touchUpInside)
    recordButton.backgroundColor = UIColor.orange
    self.addSubview(recordButton)
    
    recordButton.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
    recordButton.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
    recordButton.autoSetDimensions(to: CGSize(width: wid, height: wid))
    
    // 
    playButton.layer.masksToBounds = true
    playButton.layer.cornerRadius  = 16
    playButton.backgroundColor = .lightGray
    playButton.setImage(UIImage(named: "bofang"), for: .normal)
    playButton.addTarget(self, action: #selector(playRecord), for: .touchUpInside)
    recordButton.addSubview(playButton)
    
    playButton.autoPinEdge(toSuperviewEdge: .right, withInset: 15)
    playButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 15)
    playButton.autoSetDimensions(to: CGSize(width: 32, height: 32))
    
    //
    recordNameLabel.font = UIFont(name: "PingFangSC-Regular", size: 14)
    recordNameLabel.textColor = UIColor.black // #333333
    recordNameLabel.text = "未来日记"
    self.addSubview(recordNameLabel)
    
    recordNameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
    recordNameLabel.autoPinEdge(.top, to: .bottom, of: recordButton, withOffset: 13)
    recordNameLabel.autoSetDimensions(to: CGSize(width: wid, height: 20))
    
    //
    recordOwnerNameLabel.font = UIFont(name: "PingFangSC-Regular", size: 10)
    recordOwnerNameLabel.textColor = UIColor.lightGray // #888888
    recordOwnerNameLabel.text = "金玟岐"
    self.addSubview(recordOwnerNameLabel)
    
    recordOwnerNameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
    recordOwnerNameLabel.autoPinEdge(.top, to: .bottom, of: recordNameLabel, withOffset: 2)
    recordOwnerNameLabel.autoSetDimensions(to: CGSize(width: wid, height: 14))
    
    //
    recordReleaseTimeLabel.font = UIFont(name: "PingFangSC-Regular", size: 10)
    recordReleaseTimeLabel.textColor = UIColor.lightGray // #888888
    recordReleaseTimeLabel.text = "2017.06.30"
    self.addSubview(recordReleaseTimeLabel)
    recordReleaseTimeLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
    recordReleaseTimeLabel.autoPinEdge(.top, to: .bottom, of: recordOwnerNameLabel, withOffset: 0)
    recordReleaseTimeLabel.autoSetDimensions(to: CGSize(width: wid, height: 14))
  
  }
  
  @objc func recordHandler(button: UIButton) {
    if let handler = ietmRecordPushHandler {
      handler()
    }
    
  }
  
  
  @objc func playRecord(button: UIButton) {
    
    if let handler = itemRecordPalyHandler {
      handler()
    }
  }
}
