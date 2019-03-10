//
//  MusicianSegmentView.swift
//  Swift_test
//
//  Created by yytmzys on 2018/12/19.
//  Copyright © 2018 yytmzys. All rights reserved.
//

import UIKit

class MusicianSegmentView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(contentView)
    contentView.addSubview(segment)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  lazy var segment: ZFXSegmentView = {
    let configs = [ZFXSegmentViewItemConfig("精选歌曲"),
                   ZFXSegmentViewItemConfig("唱片"),
                   ZFXSegmentViewItemConfig("相似艺术家"),
                   ZFXSegmentViewItemConfig("详情") ]
    
    let segmentView = ZFXSegmentView(frame: .zero)
    segmentView.contentInsets = UIEdgeInsets(top: 0, left: 25, bottom: 9, right: 0)
    segmentView.configure(items: configs, startIndex: 0)
    segmentView.itemSpacing    = 18
    segmentView.miniFontSize   = 14
    segmentView.normalFontSize = 20
    
    
    return segmentView
  }()
  
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let contentFrame = bounds
    contentView.frame = contentFrame
    
    segment.frame = CGRect(x: 0, y: 0, width: contentFrame.width, height: contentFrame.height)
  }
  
  //Private Methods
  
  fileprivate lazy var contentView: UIView = {
    let view = UIView(frame: CGRect.zero)
    return view
  }()
  
}

