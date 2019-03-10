//
//  ZFSlideSegmentView.swift
//  SlideVC
//
//  Created by zhifei on 16/8/22.
//  Copyright © 2016年 Atelas. All rights reserved.
//

import Foundation
import UIKit

private let animationDuration: TimeInterval = 0.3
private let segmentItemIdentifer       = "segmentItemIdentifer"

extension CGFloat {
  
  func zf_increasing(_ scale: CGFloat, endNum: CGFloat) -> CGFloat {
    return (endNum - self) * scale + self
  }
  
}

class ZFSlideSegmentView: UIView {
  
  var indicatorHeight: CGFloat = 2
  var indicatorBottom: CGFloat = 2
  var indicatorColor: UIColor = UIColor.red
  var indicatorColors: [UIColor] = []
  var didSelectHandler: ((Int)->())?
  var startIndex: Int {
    set {
      collectionView.startIndex = newValue
    }
    get {
      return collectionView.startIndex
    }
  }
  
  func getSegmentBarItem(index: Int) -> ZFSegmentLabel? {
//    if index < getSegmentBarItems().count {
      return getSegmentBarItems()[index]
//    }
//    return getSegmentBarItems().zf_objectAtIndex(index)
  }
  
  func getSegmentBarItems() -> [ZFSegmentLabel] {
    return collectionView.segmentlabels
  }
  
  fileprivate(set) internal var selectIndex: Int {
    set {
      collectionView.selectedIndex = newValue
    }
    get {
      return collectionView.selectedIndex
    }
  }
  
  init(frame: CGRect, contentEdge: UIEdgeInsets, configs: [ZFSegmentConfig]) {
    super.init(frame: frame)
    
    self.contentEdge = contentEdge
    itemCount = configs.count
    collectionView.configure(configs: configs)
    
    addSubview(collectionView)
    addSubview(indicatorView)
    applyConstraints()
    
    collectionView.contentLabelFramesChangedHandler = {
      [weak self] (frames) in
      guard let `self` = self else { return }
      
      var indicatorFrames: [CGRect] = []
      for frame in frames {
        let indicatorframe = CGRect(
          x: frame.origin.x + self.collectionView.frame.origin.x,
          y: self.bounds.size.height - self.indicatorHeight - self.indicatorBottom,
          width: frame.width,
          height: self.indicatorHeight)
        indicatorFrames.append(indicatorframe)
      }
      self.indicatorViewFrames = indicatorFrames
      self.resetIndicatorViewFrames(false)
      self.resetIndicatorViewColor(self.selectIndex)
    }
    
    collectionView.didSelectHandler = {
      [weak self] (oldIndex, newIndex) in
      guard let `self` = self else { return }
      if oldIndex != newIndex, let handler = self.didSelectHandler {
        handler(newIndex)
      }
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setSelectedIndex(_ index: Int, animated: Bool) {
    if index <= itemCount - 1 {
      indicatorView.isHidden = false
      let endIndex = min(index, max(0, indicatorViewFrames.count - 1))
      resetIndicatorViewFrame(CGFloat(index), animated: animated)
      resetIndicatorViewColor(endIndex)
    } else {
      indicatorView.isHidden = true
    }
    self.selectIndex = index
  }
  
  func scrollToIndex(_ index: CGFloat, animated: Bool) {
    if index <= CGFloat(itemCount) - 1 {
      indicatorView.isHidden = false
      let endIndex = min(Int(ceil(index)), max(0, indicatorViewFrames.count - 1))
      resetIndicatorViewFrame(index, animated: animated)
      resetIndicatorViewColor(endIndex)
    } else {
      indicatorView.isHidden = true
    }
    if index == CGFloat(Int(index)) {
      self.selectIndex = Int(index)
    }
  }
  
  func scrollToIndex(_ index: CGFloat, animated: Bool, finishIndex: Int) {
    if index <= CGFloat(itemCount) - 1 {
      indicatorView.isHidden = false
      resetIndicatorViewFrame(index, animated: animated)
      resetIndicatorViewColor(finishIndex)
    } else {
      indicatorView.isHidden = true
    }
    if index == CGFloat(Int(index)) {
      self.selectIndex = Int(index)
    }
  }
  
  //MARK: Private Methods
  
  fileprivate var contentEdge: UIEdgeInsets = UIEdgeInsets.zero
  fileprivate var itemSize = CGSize.zero
  fileprivate var indicatorViewFrames: [CGRect] = []
  fileprivate var itemCount = 0
  
  fileprivate lazy var indicatorView: UIView = {
    let view = UIView(frame: CGRect.zero)
    view.backgroundColor = UIColor.red
    return view
  }()
  
  fileprivate lazy var collectionView: ZFSegmentView = {
    let view = ZFSegmentView(frame: .zero,
                             contentEdge: .zero,
                             configs: [],
                             type: .same)
    return view
  }()
  
  fileprivate func resetIndicatorViewFrames(_ animated: Bool) {
    if self.indicatorView.isHidden == false {
      if animated {
        UIView.animate(withDuration: animationDuration,
                                   animations: {
                                    self.indicatorView.frame = self.indicatorViewFrames[self.collectionView.selectedIndex]
        }, completion: { (finished) in
          //
        }) 
      } else {
        self.indicatorView.frame = self.indicatorViewFrames[self.collectionView.selectedIndex]
      }
    }
  }
  
  fileprivate func resetIndicatorViewFrame(_ index: CGFloat, animated: Bool) {
    if CGFloat(indicatorViewFrames.count) > index {
      let startIndex = Int(floor(index))
      let endIndex = min(Int(ceil(index)), max(0, indicatorViewFrames.count - 1))
      let startFrame = indicatorViewFrames[startIndex]
      let endFrame = indicatorViewFrames[endIndex]
      
      let toFrame = CGRect(
        x: startFrame.origin.x.zf_increasing((index - CGFloat(startIndex)), endNum: endFrame.origin.x),
        y: endFrame.origin.y,
        width: startFrame.width.zf_increasing((index - CGFloat(startIndex)), endNum: endFrame.width),
        height: endFrame.height)
      if animated {
        UIView.animate(withDuration: animationDuration,
                                   animations: {
                                    self.indicatorView.frame = toFrame
        })
      } else {
        indicatorView.frame = toFrame
      }
    }
  }
  
  fileprivate func resetIndicatorViewColor(_ index: Int) {
    if indicatorColors.count > index {
      indicatorView.backgroundColor = indicatorColors[index]
    }  else {
      indicatorView.backgroundColor = indicatorColor
    }
  }
  
  fileprivate func applyConstraints() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    addConstraint(NSLayoutConstraint(item: collectionView,
      attribute: .top,
      relatedBy: .equal,
      toItem: self,
      attribute: .top,
      multiplier: 1,
      constant: contentEdge.top))
    addConstraint(NSLayoutConstraint(item: collectionView,
      attribute: .left,
      relatedBy: .equal,
      toItem: self,
      attribute: .left,
      multiplier: 1,
      constant: contentEdge.left))
    addConstraint(NSLayoutConstraint(item: collectionView,
      attribute: .bottom,
      relatedBy: .equal,
      toItem: self,
      attribute: .bottom,
      multiplier: 1,
      constant: contentEdge.bottom))
    addConstraint(NSLayoutConstraint(item: collectionView,
      attribute: .right,
      relatedBy: .equal,
      toItem: self,
      attribute: .right,
      multiplier: 1,
      constant: contentEdge.right))
  }
  
}
