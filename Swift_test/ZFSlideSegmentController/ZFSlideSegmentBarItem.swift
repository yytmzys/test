//
//  ZFSlideSegmentBarItem.swift
//  SlideVC
//
//  Created by zhifei on 16/8/18.
//  Copyright © 2016年 Atelas. All rights reserved.
//

import Foundation
import UIKit

class ZFSlideSegmentBarItem: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(titleLabel)
    applyConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //Private Methods
  
  lazy var titleLabel: UILabel = {
    let label = UILabel(frame: CGRect.zero)
    label.textAlignment = .center
    return label
  }()
  
  fileprivate func applyConstraints() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    addConstraint(NSLayoutConstraint(item: titleLabel,
      attribute: .centerX,
      relatedBy: .equal,
      toItem: self,
      attribute: .centerX,
      multiplier: 1,
      constant: 0))
    addConstraint(NSLayoutConstraint(item: titleLabel,
      attribute: .centerY,
      relatedBy: .equal,
      toItem: self,
      attribute: .centerY,
      multiplier: 1,
      constant: 0))
  }
  
}
