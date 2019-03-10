//
//  ZFXSegmentView.swift
//  ZFXSegmentView
//
//  Created by zhifei qiu on 2018/11/28.
//  Copyright © 2018 zhifei qiu. All rights reserved.
//

import Foundation
import UIKit
import PureLayout


class ZFXSegmentView: UIView {
  
  var selectedIndexChangedHandler: (()->())?
  
  var itemSpacing: CGFloat = 20           // 间距
  var textColor: UIColor = .black         // 文字颜色
  var duration: TimeInterval = 0.25       // 动画时长
  var contentInsets: UIEdgeInsets = .zero
  var miniFontSize: CGFloat = ZFXSegmentViewConfig.miniFontSize
  var normalFontSize: CGFloat = ZFXSegmentViewConfig.normalFontSize
  
  //////////////////
  
  fileprivate let contentView = UIView(frame: .zero)
  fileprivate var itemViews: [ZFXSegmentViewItem] = []
  
  fileprivate var items: [ZFXSegmentViewItemConfig] = []
  
  public fileprivate(set) var selectedIndex: Int = 0
  
  fileprivate var containerSize: CGSize = .zero
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var intrinsicContentSize: CGSize {
    return self.containerSize
  }
  
}


extension ZFXSegmentView {
  
  // 设置滑动偏移量
  func configure(progress: CGFloat) {
    var intrinsicProgress = max(progress, 0)
    intrinsicProgress = min(intrinsicProgress, CGFloat(self.items.count) - 1)
    
    for (index, view) in itemViews.enumerated() {
      if index == Int(floor(intrinsicProgress)) {
        // 偏移量 左
        let offset = intrinsicProgress - CGFloat(index)
        view.configure(fontSize: normalFontSize - (normalFontSize - miniFontSize) * offset)
      } else if index == Int(ceil(intrinsicProgress)) {
        // 偏移量 右
        let offset = 1 - (CGFloat(index) - intrinsicProgress)
        view.configure(fontSize: miniFontSize + (normalFontSize - miniFontSize) * offset)
      } else {
        // 其他
        view.configure(fontSize: miniFontSize)
      }
      
      let size = view.intrinsicContentSize
      view.configure(size: size)
    }
    
    // 整数时，赋值为 selectedIndex
    if progress == floor(progress) {
      self.selectedIndex = Int(progress)
    }
  }
  
  func configure(items: [ZFXSegmentViewItemConfig], startIndex: Int) {
    self.items = items
    self.selectedIndex = max(0, min(startIndex, items.count - 1))
    
    if items.count != itemViews.count {
      for view in itemViews {
        view.removeFromSuperview()
      }
      itemViews = []
    }
    
    if items.count != itemViews.count {
      for _ in items {
        let view = ZFXSegmentViewItem(frame: .zero)
        view.miniFontSize = self.miniFontSize
        view.normalFontSize = self.normalFontSize
        contentView.addSubview(view)
        itemViews.append(view)
      }
      
      var previousView: ZFXSegmentViewItem?
      for view in itemViews {
        // 距离左侧间距
        if let previousView = previousView {
          view.autoPinEdge(.left, to: .right, of: previousView, withOffset: itemSpacing)
        } else {
          view.autoPinEdge(toSuperviewEdge: .left, withInset: contentInsets.left)
        }
        
        // 距离下侧间距
        view.autoPinEdge(toSuperviewEdge: .bottom, withInset: contentInsets.bottom)
        
        // 距离右侧间距
        //      itemViews.last?.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
        
        previousView = view
      }
    }
    
    if items.count == itemViews.count {
      for (index, item) in items.enumerated() {
        let view = itemViews[index]
        view.configure(textColor: textColor)
        view.configure(text: item.title)
        
        if self.selectedIndex == index {
          view.configure(fontSize: normalFontSize)
        } else {
          view.configure(fontSize: miniFontSize)
        }
        
        let size = view.intrinsicContentSize
        view.configure(size: size)
      }
    }
    
    // reset container size
    var miniSizes: [CGSize] = []
    var normalSizes: [CGSize] = []
    let view = ZFXSegmentViewItem(frame: .zero)
    for item in self.items {
      view.configure(text: item.title)
      
      view.configure(fontSize: miniFontSize)
      miniSizes.append(view.intrinsicContentSize)
      
      view.configure(fontSize: normalFontSize)
      normalSizes.append(view.intrinsicContentSize)
    }
    
    var containerWidth: CGFloat = 0
    var containerHeight: CGFloat = 0
    for (index, _) in self.items.enumerated() {
      containerHeight = max(containerHeight, normalSizes[index].height)
      
      var maxWidth: CGFloat = 0
      for i in 0..<self.items.count {
        if index == i {
          maxWidth += normalSizes[i].width
        } else {
          maxWidth += miniSizes[i].width
        }
      }
      // 添加间距
      maxWidth += itemSpacing * CGFloat((self.items.count - 1))
        
      containerWidth = max(containerWidth, maxWidth)
    }
    
    // 添加间距
    containerWidth += contentInsets.left + contentInsets.right
    containerHeight += contentInsets.top + contentInsets.bottom
    
    self.containerSize = CGSize(width: containerWidth, height: containerHeight)
  }
  
}


fileprivate extension ZFXSegmentView {
  
  func setup() {
    self.addSubview(contentView)
    _ = contentView.autoPinEdgesToSuperviewEdges(with: .zero)
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(handleSelectItem(tap:)))
    tap.numberOfTapsRequired = 1
    tap.numberOfTouchesRequired = 1
    contentView.isUserInteractionEnabled = true
    contentView.addGestureRecognizer(tap)
  }
  
  @objc func handleSelectItem(tap: UITapGestureRecognizer) {
    let point = tap.location(in: tap.view)
    
    var selectedIndex: Int = NSNotFound
    for (index, view) in itemViews.enumerated() {
      let frame = view.frame
      let targetFrame = CGRect(x: frame.origin.x - itemSpacing/2,
                               y: 0,
                               width: frame.width + itemSpacing,
                               height: contentView.bounds.height)
      if targetFrame.contains(point) {
        selectedIndex = index
        break
      }
    }
    
    if selectedIndex == NSNotFound {
      // 不在预期范围内
      return
    }
    
    if selectedIndex == self.selectedIndex {
      // 重复
      return
    }
    self.selectedIndex = selectedIndex
    
    UIView.animate(withDuration: self.duration) {
      for (index, view) in self.itemViews.enumerated() {
        if index == selectedIndex {
          view.configure(fontSize: self.normalFontSize)
        } else {
          view.configure(fontSize: self.miniFontSize)
        }
        
        let size = view.intrinsicContentSize
        view.configure(size: size)
      }
      
      self.layoutIfNeeded()
    }
    
    if let handler = self.selectedIndexChangedHandler {
      handler()
    }
  }
  
}
