//
//  MyOfflineHeaderItemView.swift
//  Swift_test
//
//  Created by yytmzys on 2018/12/7.
//  Copyright © 2018 yytmzys. All rights reserved.
//

import UIKit

class MyOfflineHeaderItemView: UIView {

  var pushSongHandler:(()->())?
  var playSongHandler:(()->())?
  
  fileprivate let totalLabel = UILabel(frame: .zero)
  fileprivate let nameLabel = UILabel(frame: .zero)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  /*
  // Only override draw() if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func draw(_ rect: CGRect) {
      // Drawing code
  }
  */

}

extension MyOfflineHeaderItemView {
  func configure() {
    nameLabel.text  = "xx歌曲"
    totalLabel.text = "x首"
  }
}

fileprivate extension MyOfflineHeaderItemView {
  
  func setup() {
    
    let containerView = UIControl(frame: .zero)
    containerView.backgroundColor = UIColor.white
    containerView.layer.shadowColor = UIColor.red.cgColor // #C3C3C3
    containerView.layer.shadowOffset = CGSize(width: 0, height: 5)
    containerView.layer.shadowOpacity = 1
    containerView.layer.shadowRadius = 17
    containerView.layer.cornerRadius = 4
    containerView.addTarget(self, action: #selector(pushSong), for: .touchUpInside)
    self.addSubview(containerView)
    
    containerView.autoPinEdge(toSuperviewEdge: .left, withInset: 25)
    containerView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
    containerView.autoPinEdge(toSuperviewEdge: .right, withInset: 25)
    containerView.autoSetDimension(.height, toSize: 80)
    
    
    let imageView = UIImageView(frame: .zero)
    imageView.image = UIImage(named: "music")
    containerView.addSubview(imageView)
    imageView.autoPinEdge(toSuperviewEdge: .left, withInset: 29)
    imageView.autoPinEdge(toSuperviewEdge: .top, withInset: 29)
    imageView.autoSetDimensions(to: CGSize(width: 24, height: 23))
    
    
    nameLabel.font = UIFont(name: "PingFangSC-Semibold", size: 16)
    nameLabel.textColor = UIColor.black // #333333
    nameLabel.text = "全部歌曲"
    containerView.addSubview(nameLabel)
    nameLabel.autoPinEdge(.left, to: .right, of: imageView, withOffset: 22)
    nameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 21)
    nameLabel.autoSetDimensions(to: CGSize(width: 100, height: 22))
    
    
    totalLabel.font = UIFont(name: "PingFangSC-Regular", size: 10)
    totalLabel.textColor = UIColor.black // #555555
    totalLabel.text = "暂无离线"
    containerView.addSubview(totalLabel)
    totalLabel.autoPinEdge(.left, to: .right, of: imageView, withOffset: 22)
    totalLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 3.5)
    totalLabel.autoSetDimensions(to: CGSize(width: 100, height: 14))
    
    
    let playButton = UIButton(type: .custom)
    playButton.setImage(UIImage(named: "bofang"), for: .normal)
    containerView.addSubview(playButton)
    playButton.addTarget(self, action: #selector(playSong), for: .touchUpInside)
    playButton.autoPinEdge(toSuperviewEdge: .top, withInset: 28)
    playButton.autoPinEdge(toSuperviewEdge: .right, withInset: 25)
    playButton.autoSetDimensions(to: CGSize(width: 24, height: 24))
    
  }
  
  
  @objc func pushSong() {
    if let handler = pushSongHandler {
      handler()
    }
  }
  
  
  @objc func playSong() {
    if let handler = playSongHandler {
      handler()
    }
  }
  
}

