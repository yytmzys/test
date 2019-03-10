//
//  ZFSlideSegmentController.swift
//  DoubanRadio
//
//  Created by zhifei on 16/8/25.
//  Copyright © 2016年 Douban Inc. All rights reserved.
//

import Foundation
import UIKit

@objc enum ZFDirection: Int {
  case left = 0
  case right
}

class ZFSlideSegmentController: UIViewController, UIScrollViewDelegate {
  
  var endScrollingHandler: ((_ slideVC: ZFSlideSegmentController, _ index: Int)->())?
  var scrollViewDidEndDraggingBouncesHandler: ((_ slideVC: ZFSlideSegmentController, _ direction: ZFDirection)->())?
  var didScrollingHandler: ((_ slideVC: ZFSlideSegmentController, _ slideView: ZFSlideView, _ direction: ZFDirection)->())?
  
  var contentInsets: UIEdgeInsets = .zero
  
  init(_ viewControllers: [UIViewController], startIndex: Int) {
    super.init(nibName: nil, bundle: nil)
    self.viewControllers = viewControllers
    if startIndex < 0 || startIndex >= viewControllers.count {
      self.startIndex = 0
    } else {
      self.startIndex = startIndex
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var startIndex: Int = 0
  fileprivate(set) internal var viewControllers: [UIViewController]! {
    didSet {
      for vc in viewControllers {
        vc.willMove(toParent: nil)
        vc.view.removeFromSuperview()
        vc.removeFromParent()
        vc.didMove(toParent: nil)
      }
    }
  }
  var selectedViewController: UIViewController? {
    get {
      return selectedIndex < viewControllers.count ? viewControllers[selectedIndex] : nil
    }
  }
  fileprivate var _selectedIndex = NSNotFound
  fileprivate(set) internal var selectedIndex: Int {
    set {
      if _selectedIndex != newValue
        && newValue < viewControllers.count {
        previousIndex = _selectedIndex
        _selectedIndex = newValue
        _selectedIndex = _selectedIndex == NSNotFound ? 0 : _selectedIndex
        let toSelectVC = viewControllers[_selectedIndex]
        if toSelectVC.parent == nil {
          addChild(toSelectVC)
          configureViewControllerFrame(toSelectVC)
          slideView.addSubview(toSelectVC.view)
          toSelectVC.didMove(toParent: self)
        }
      }
    }
    get {
      return _selectedIndex
    }
  }
  
  fileprivate(set) internal var endIndex: Int = 0
  
  func setSelectedIndex(_ index: Int, animated: Bool) {
    if selectedIndex != index {
      selectedIndex = index
      endIndex = selectedIndex
      scrollToView(index, animated: animated)
    }
  }
  
  //MARK: Overrite
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    slideView.scrollViewDidEndDraggingBouncesHandler = {
      [weak self](direction) in
      guard let `self` = self else { return }
      if let handler = self.scrollViewDidEndDraggingBouncesHandler {
        handler(self, direction)
      }
    }
    slideView.frame = CGRect(x: contentInsets.left,
                             y: contentInsets.top,
                             width: self.view.bounds.width - contentInsets.left - contentInsets.right,
                             height: self.view.bounds.height - contentInsets.top - contentInsets.bottom)
    slideView.delegate = self
    view.addSubview(slideView)
    
    adjustContentSize()
    selectedIndex = startIndex
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if isFirstShow {
      isFirstShow = false
      adjustContentSize()
      selectedIndex = startIndex
      scrollToView(selectedIndex, animated: false)
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    slideView.frame = CGRect(x: contentInsets.left,
                             y: contentInsets.top,
                             width: self.view.bounds.width - contentInsets.left - contentInsets.right,
                             height: self.view.bounds.height - contentInsets.top - contentInsets.bottom)
    adjustContentSize()
    if let vc = selectedViewController {
      configureViewControllerFrame(vc)
    }
  }
  
  //MARK: UIScrollViewDelegate
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let percent = scrollView.contentOffset.x / scrollView.contentSize.width
    let destination = percent * CGFloat(viewControllers.count)
    let index = Int(destination >= lastDestination ? ceilf(Float(destination)) : floor(Float(destination)))
    if index >= 0 && index < viewControllers.count  {
      selectedIndex = index
    }
    lastDestination = destination
    if let handler = didScrollingHandler {
      handler(self, slideView, slideView.scrollDirection)
    }
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    removePreviousViewController()
    if let handler = endScrollingHandler {
      endIndex = selectedIndex
      handler(self, selectedIndex)
    }
  }
  
  func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    removePreviousViewController()
    if let handler = endScrollingHandler {
      handler(self, selectedIndex)
    }
  }
  
  //MARK: Private Methods
  
  fileprivate var isFirstShow = true
  fileprivate var lastDestination: CGFloat = 0
  fileprivate var previousIndex: Int = NSNotFound
  
  fileprivate func scrollToView(_ index: Int, animated: Bool) {
    var rect = slideView.bounds
    rect.origin.x = rect.width * CGFloat(index)
    slideView.setContentOffset(rect.origin, animated: animated)
  }
  
  fileprivate lazy var slideView: ZFSlideView = {
    let slideView = ZFSlideView(frame: CGRect.zero)
    slideView.isScrollEnabled = self.viewControllers.count > 1
    slideView.scrollsToTop = false
    slideView.showsHorizontalScrollIndicator = false
    slideView.showsVerticalScrollIndicator = false
    slideView.isPagingEnabled = true
    slideView.bounces = false
    if #available(iOS 11.0, *)  {
      slideView.contentInsetAdjustmentBehavior = .never
    }
    return slideView
  }()
  
  fileprivate func configureViewControllerFrame(_ vc: UIViewController) {
    let configView = vc.view
    if let index = viewControllers.index(of: vc) {
      configView?.frame = CGRect(x: slideView.bounds.width * CGFloat(index), y: 0, width: slideView.bounds.width, height: slideView.bounds.height)
    }
  }
  
  fileprivate func adjustContentSize() {
    let contentSize = CGSize(width: slideView.bounds.width * CGFloat(viewControllers.count), height: slideView.bounds.height)
    slideView.contentSize = contentSize
  }
  
  fileprivate func removePreviousViewController() {
    for (index, vc) in viewControllers.enumerated() {
      if index != selectedIndex {
        if let _ = vc.parent {
          vc.willMove(toParent: nil)
          vc.view.removeFromSuperview()
          vc.removeFromParent()
        }
      }
    }
  }
  
}

class ZFSlideView: UIScrollView {
  
  fileprivate var scrollDirection: ZFDirection = .left
  var scrollViewDidEndDraggingBouncesHandler: ((ZFDirection)->())?
  
  override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    
    if let panGes = gestureRecognizer as? UIPanGestureRecognizer {
      let transPoint = panGes.translation(in: self)
      let offset = self.contentOffset
      scrollDirection = transPoint.x > 0 ? .left : .right
      if transPoint.x > 0 && offset.x == 0 {
        if let handler = scrollViewDidEndDraggingBouncesHandler {
          handler(.left)
        }
        return false
      }
      if transPoint.x < 0 && contentSize.width - offset.x - bounds.size.width == 0 {
        if let handler = scrollViewDidEndDraggingBouncesHandler {
          handler(.right)
        }
        return false
      }
    }
    return true
  }
  
}
