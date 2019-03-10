//
//  ZFXSegmentViewItemConfig.swift
//  ZFXSegmentView
//
//  Created by zhifei qiu on 2018/11/28.
//  Copyright © 2018 zhifei qiu. All rights reserved.
//

import Foundation
import UIKit

// 封装为 config，是为后续扩展
struct ZFXSegmentViewItemConfig {
  
  var title: String = ""
  
  init(_ title: String) {
    self.title = title
  }
  
}
