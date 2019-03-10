//
//  AlbumDetailCell2.swift
//  Swift_test
//
//  Created by yytmzys on 2018/12/29.
//  Copyright © 2018 yytmzys. All rights reserved.
//

import UIKit

class AlbumDetailCell2: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup() {
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 20))
    label.backgroundColor = .red
    addSubview(label)
  }
  
}
