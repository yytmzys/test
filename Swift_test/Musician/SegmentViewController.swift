//
//  SegmentViewController.swift
//  Swift_test
//
//  Created by yytmzys on 2019/1/13.
//  Copyright © 2019 yytmzys. All rights reserved.
//

import UIKit

class SegmentViewController: UIViewController , UIScrollViewDelegate, UIGestureRecognizerDelegate{
  
  fileprivate var scrollView: UIScrollView?
  fileprivate var canScroll = false
  
  override func viewDidLoad() {
    NotificationCenter.default.addObserver(self, selector: #selector(acceptMsg), name: NSNotification.Name(rawValue: "goTop"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(acceptMsg), name: NSNotification.Name(rawValue: "leaveTop"), object: nil)
  }
  
  @objc fileprivate func acceptMsg(_ notification: NSNotification) {
    let notificationName = notification.name.rawValue
    if notificationName == "goTop" {
      let userInfo = notification.userInfo
      let canScroll: String = userInfo!["canScroll"] as! String
      if canScroll == "1" {
        self.canScroll = true
        self.scrollView?.showsVerticalScrollIndicator = true
      } else {
        self.canScroll = false
      }
      
    } else if notificationName == "leaveTop" {
      self.canScroll = false
      self.scrollView?.contentOffset = .zero
      self.scrollView?.showsVerticalScrollIndicator = false
    }
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if !self.canScroll {
      scrollView.contentOffset = .zero
    }
    let offsetY = scrollView.contentOffset.y
    let zero: CGFloat = 0
    if offsetY <= zero {
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "leaveTop"), object: nil, userInfo: ["canScroll":"1"])
    }
    
    self.scrollView = scrollView
  }
  
}
