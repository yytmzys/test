//
//  DOUSonglistHeaderView.swift
//  DoubanRadio
//
//  Created by zhifei qiu on 2018/11/23.
//  Copyright © 2018 Douban Inc. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class DOUSonglistHeaderView: UIView {
  
    var songImageViewTapHander: (()->())?
    
  var downloadHandler: (()->())?
  var shareHandler: (()->())?
  var collectHandler: (()->())?
  
        
  public var songListImageView = UIImageView(frame: .zero)
  fileprivate let playListNameLabel = UILabel(frame: .zero)
  fileprivate let userNameLabel     = UILabel(frame: .zero)
  fileprivate let arrowImageV       = UIImageView(frame: .zero)
  fileprivate let timeTotalLabel    = UILabel(frame: .zero)
  fileprivate let detailLabel       = UILabel(frame: .zero)
  fileprivate let downLoadButton    = UIButton(type: .custom)
  fileprivate let collectButton     = UIButton(type: .custom)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


extension DOUSonglistHeaderView {
  
  func configure() {
    
    resetCollectState()
    resetDownloadState()
    
    
    playListNameLabel.text = "望向窗外的你想什么"
    userNameLabel.text     = "WHKKBHJ >"
    timeTotalLabel.text    = "创建于2017.10.11  共10首"
    detailLabel.text       = "欢迎来到这里，这里是哪里，这是一片深邃如谜的海，是你我。"
  }
  
  func resetDownloadState() {
//    if let songlist = self.songlist {
//      let canOfflineSongs = DOUFMOfflineSongsManager.shared()!.getCanOfflineSongs(songlist.songs)
//      downLoadButton.isSelected = canOfflineSongs.count == 0
//    } else {
//      downLoadButton.isSelected = false
//    }
  }
  
  func resetCollectState() {
  }
  
}


fileprivate extension DOUSonglistHeaderView {
  
  func setup() {

    songListImageView.image = UIImage(named: "占位图")
    songListImageView.backgroundColor = UIColor.green
    songListImageView.isUserInteractionEnabled = true
    let imageViewTap = UITapGestureRecognizer(target: self, action: #selector(songImageViewTap))
    songListImageView.addGestureRecognizer(imageViewTap)
    
    self.addSubview(songListImageView)
    songListImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 25)
    songListImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 23)
    songListImageView.autoSetDimensions(to: CGSize(width: 120, height: 120))
    
    
    let tipLabel = UILabel(frame: .zero)
    tipLabel.text = "歌单"
    tipLabel.font = UIFont.systemFont(ofSize: 10)
    tipLabel.textAlignment   = .center
    tipLabel.textColor       = .white
    tipLabel.backgroundColor = .black
    tipLabel.layer.masksToBounds = true
    tipLabel.layer.cornerRadius  = 3
    
    self.addSubview(tipLabel)
    tipLabel.autoPinEdge(.left, to: .right, of: songListImageView, withOffset: 20)
    tipLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 38)
    tipLabel.autoSetDimensions(to: CGSize(width: 35, height: 20))
    
    
    playListNameLabel.font = UIFont.systemFont(ofSize: 20)
    playListNameLabel.numberOfLines = 0
    playListNameLabel.textColor = UIColor.black
    
    self.addSubview(playListNameLabel)
    playListNameLabel.autoPinEdge(.left, to: .right, of: songListImageView, withOffset: 20)
    playListNameLabel.autoPinEdge(.top, to: .bottom, of: tipLabel, withOffset: 9)
    playListNameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 25)
    playListNameLabel.autoSetDimension(.height, toSize: 26)
//    _ = playListNameLabel.zf_pinEdge(edge: .top, toEdge: .bottom, ofView: tipLabel, offset: 6)
    
    
    userNameLabel.font = UIFont.systemFont(ofSize: 12)
    userNameLabel.textColor = UIColor.darkGray
    userNameLabel.numberOfLines = 0
    
    self.addSubview(userNameLabel)
    userNameLabel.autoPinEdge(.left, to: .right, of: songListImageView, withOffset: 20)
    userNameLabel.autoPinEdge(.top, to: .bottom, of: playListNameLabel, withOffset: 4)
    userNameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 25)
    userNameLabel.autoSetDimension(.height, toSize: 17)
//    _ = userNameLabel.zf_pinEdge(edge: .top, toEdge: .bottom, ofView: playListNameLabel, offset: 0)
    
    
    timeTotalLabel.font = UIFont.systemFont(ofSize: 10)
    timeTotalLabel.textColor = UIColor.darkGray
    
    self.addSubview(timeTotalLabel)
    timeTotalLabel.autoPinEdge(.left, to: .right, of: songListImageView, withOffset: 20)
    timeTotalLabel.autoPinEdge(.top, to: .bottom, of: userNameLabel, withOffset: 1)
    timeTotalLabel.autoSetDimensions(to: CGSize(width: 150, height: 14))
//    _ = timeTotalLabel.zf_pinEdge(edge: .top, toEdge: .bottom, ofView: userNameLabel, offset: 0)
    
    
    detailLabel.font = UIFont.systemFont(ofSize: 14)
    detailLabel.textColor = UIColor.darkText
    detailLabel.numberOfLines = 0
    
    self.addSubview(detailLabel)
    detailLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 25)
    detailLabel.autoPinEdge(.top, to: .bottom, of: songListImageView, withOffset: 15)
    detailLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 25)
    detailLabel.autoSetDimension(.height, toSize: 46)
//    _ = detailLabel.zf_pinEdge(edge: .top, toEdge: .bottom, ofView: timeTotalLabel, offset: 16)
    
    
    downLoadButton.addTarget(self, action: #selector(handleDownload), for: UIControl.Event.touchUpInside)
    
    self.addSubview(downLoadButton)
    downLoadButton.autoPinEdge(toSuperviewEdge: .left, withInset: 25)
    downLoadButton.autoPinEdge(.top, to: .bottom, of: detailLabel, withOffset: 20)
    downLoadButton.autoSetDimensions(to: CGSize(width: 24, height: 24))
    
    
    let shareButton = UIButton(frame: .zero)
    shareButton.addTarget(self, action: #selector(handleShare), for: UIControl.Event.touchUpInside)
    
    self.addSubview(shareButton)
//    _ = shareButton.zf_pinEdge(edge: .left, toEdge: .right, ofView: downLoadButton, offset: 24)
    shareButton.autoAlignAxis(.horizontal, toSameAxisOf: downLoadButton)
    
    
    collectButton.setTitle("收藏", for: UIControl.State.normal)
    collectButton.setTitle("已收藏", for: UIControl.State.selected)
    collectButton.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
    collectButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    collectButton.addTarget(self, action: #selector(handleCollect), for: UIControl.Event.touchUpInside)
    collectButton.layer.masksToBounds = true
    collectButton.layer.cornerRadius  = 17.5
    collectButton.layer.borderWidth   = 2.0
    collectButton.layer.borderColor   = UIColor.darkGray.cgColor
    
    self.addSubview(collectButton)
    collectButton.isExclusiveTouch = true
    collectButton.autoPinEdge(toSuperviewEdge: .right, withInset: 25)
    collectButton.autoAlignAxis(.horizontal, toSameAxisOf: downLoadButton)
    collectButton.autoSetDimensions(to: CGSize(width: 70, height: 35))
  }
  
    @objc func songImageViewTap() {
        
        if let hander = self.songImageViewTapHander {
            hander()
        }
    }
    
  @objc func handleDownload() {
    if let handler = self.downloadHandler {
      handler()
    }
  }
  
  @objc func handleCollect() {
    if let handler = self.collectHandler {
      handler()
    }
  }
  
  @objc func handleShare() {
    if let handler = self.shareHandler {
      handler()
    }
  }
  
}
