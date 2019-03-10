//
//  ZFXSegmentViewItem.swift
//  ZFXSegmentView
//
//  Created by zhifei qiu on 2018/11/28.
//  Copyright © 2018 zhifei qiu. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

// https://medium.com/livefront/animating-font-size-in-uilabels-fb6fd273a5f3
// 小的 label 放大，会字体模糊 ... 选择大的字号缩小

fileprivate let maxFontSize: CGFloat = 100

class ZFXSegmentViewItem: UIView {
  
  var miniFontSize: CGFloat = ZFXSegmentViewConfig.miniFontSize
  var normalFontSize: CGFloat = ZFXSegmentViewConfig.normalFontSize
  
  // 计算 font size
  fileprivate var fontSize: CGFloat = ZFXSegmentViewConfig.miniFontSize
  // 计算 内容宽高
  fileprivate let label = UILabel(frame: .zero)
  // 记录 内容宽高
  fileprivate var containerSize: CGSize = .zero
  
  // 展示
  fileprivate let intrinsicLabel = UILabel(frame: .zero)
  fileprivate var intrinsicLabelSize: CGSize = .zero
  
  fileprivate var widthLayout: NSLayoutConstraint?
  fileprivate var heightLayout: NSLayoutConstraint?
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var intrinsicContentSize: CGSize {
    return containerSize
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let scaleX = bounds.size.width / intrinsicLabelSize.width
    let scaleY = bounds.size.height / intrinsicLabelSize.height
    
    intrinsicLabel.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)

    let progress = (self.fontSize - miniFontSize) / (normalFontSize - miniFontSize)
    
    // 随着字体变大，有偏移量
    // * 2 并不准确，希望有更好的解决方案
    intrinsicLabel.frame = CGRect(origin: CGPoint(x: 0, y: progress * 2), size: intrinsicLabel.frame.size)
    
    if progress < 0.2 {
      intrinsicLabel.font = UIFont.systemFont(ofSize: maxFontSize, weight: UIFont.Weight.regular)
    } else if progress < 0.6 {
      intrinsicLabel.font = UIFont.systemFont(ofSize: maxFontSize, weight: UIFont.Weight.medium)
    } else {
      intrinsicLabel.font = UIFont.systemFont(ofSize: maxFontSize, weight: UIFont.Weight.semibold)
    }
  }
  
}


extension ZFXSegmentViewItem {
  
  func configure(text: String) {
    intrinsicLabel.text = text
    intrinsicLabel.sizeToFit()
    intrinsicLabelSize = intrinsicLabel.bounds.size
    
    label.text = text
    
    resetContainerSize()
  }
  
  func configure(fontSize: CGFloat) {
    self.fontSize = fontSize
    
    label.font = UIFont.systemFont(ofSize: fontSize)
    
    resetContainerSize()
  }
  
  func configure(textColor: UIColor) {
    intrinsicLabel.textColor = textColor
  }
  
  func configure(size: CGSize) {
    self.configure(width: size.width)
    self.configure(height: size.height)
  }
  
}


fileprivate extension ZFXSegmentViewItem {
  
  func setup() {
    label.isHidden = true
    addSubview(label)
    _ = label.autoPinEdgesToSuperviewEdges(with: .zero)
    
    intrinsicLabel.font = UIFont.systemFont(ofSize: maxFontSize, weight: UIFont.Weight.semibold)
    intrinsicLabel.textAlignment = .center
    addSubview(intrinsicLabel)
  }
  
  func resetContainerSize() {
    label.sizeToFit()
    containerSize = label.bounds.size
  }
  
  func configure(width: CGFloat) {
    if let layout = self.widthLayout {
      layout.constant = width
    } else {
      self.widthLayout = self.autoSetDimension(.width, toSize: width)
    }
  }
  
  func configure(height: CGFloat) {
    if let layout = self.heightLayout {
      layout.constant = height
    } else {
      self.heightLayout = self.autoSetDimension(.height, toSize: height)
    }
  }
  
}
