//
//  DOUGuidePagesViewController.swift
//  Swift_test
//
//  Created by yytmzys on 2018/12/27.
//  Copyright © 2018 yytmzys. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class DOUGuidePagesViewController: UIViewController, UIScrollViewDelegate {
  
  fileprivate let scrollView = UIScrollView(frame: .zero)
  fileprivate let pageControl = EMPageControl(frame: .zero)
  fileprivate var offSet: CGFloat = 0
  fileprivate var currentIndex: Int = 0
  fileprivate let titles  = ["全新歌单", "海量曲库" , "歌曲离线" ,"个性化电台"]
  fileprivate let details = ["专业音乐编辑精心打造", "畅听千万音乐" , "期待已久的离线功能回归" ,"与喜欢的音乐 不期而遇"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = UIColor.white
    self.navigationController?.navigationBar.isHidden = true
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    let backImageView = UIImageView(image: UIImage(named: "引导页1"))
    self.view.addSubview(backImageView)
    backImageView.autoPinEdgesToSuperviewEdges()
    
    scrollView.contentSize = CGSize(width: width  * 4, height: 0)
    scrollView.isPagingEnabled = true
    scrollView.bounces = false
    scrollView.delegate = self
    scrollView.backgroundColor = .clear
    self.view.addSubview(scrollView)
    scrollView.autoPinEdgesToSuperviewEdges()
    
    
    for i in 0...3 {
      // 图
      let imageView = UIImageView(frame: .zero)
      imageView.backgroundColor = UIColor.red
      scrollView.addSubview(imageView)
      imageView.autoPinEdge(toSuperviewEdge: .left, withInset: width * CGFloat( i ) +  width - 259)
      imageView.autoPinEdge(toSuperviewEdge: .top, withInset: 78)
      imageView.autoSetDimensions(to: CGSize(width: 200, height: 200))
      
      // 文字
      let titleLabel = UILabel(frame: .zero)
      titleLabel.attributedText = creatLabel(titles[i])
      /// #333333, #00E1A8
      scrollView.addSubview(titleLabel)
      titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 45 + width * CGFloat( i ))
      titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: height - 242)
      titleLabel.autoSetDimension(.height, toSize: 45)
      
      let deslabel = UILabel(frame: .zero)
      deslabel.text = details[i]
      deslabel.font = UIFont(name: "PingFang-SC-Light", size: 22)
      deslabel.textColor = UIColor.black // 333333
      scrollView.addSubview(deslabel)
      deslabel.autoPinEdge(toSuperviewEdge: .left, withInset: 45 + width * CGFloat( i ))
      deslabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 12)
      deslabel.autoSetDimension(.height, toSize: 30)
    }
    
    let button = UIButton(type: .custom)
    button.setTitleColor(UIColor.green, for: .normal) // #00E1A8
    button.setTitle("立即收听", for: .normal)
    button.titleLabel?.font = UIFont(name: "PingFang-SC-Regular", size: 14)
    button.addTarget(self, action: #selector(hideGuideHandler), for: .touchUpInside)
    scrollView.addSubview(button)
    button.autoPinEdge(toSuperviewEdge: .left, withInset: width * 4 - 104)
    button.autoPinEdge(toSuperviewEdge: .top, withInset: height - 60)
    button.autoSetDimensions(to: CGSize(width: 60, height: 20))
    
    let imageView = UIImageView(frame: .zero)
    imageView.backgroundColor = UIColor.green
    scrollView.addSubview(imageView)
    imageView.autoPinEdge(.left, to: .right, of: button, withOffset: 5.5)
    imageView.autoPinEdge(.top, to: .top, of: button, withOffset: 6)
    imageView.autoSetDimensions(to: CGSize(width: 4, height: 8))
    
    pageControl.numberOfPages = titles.count
    self.view.addSubview(pageControl)
    pageControl.autoPinEdge(toSuperviewEdge: .left, withInset: 50)
    pageControl.autoPinEdge(toSuperviewEdge: .bottom, withInset: 50)
    pageControl.autoSetDimensions(to: CGSize(width: 45, height: 5))
  }
  
  
  
  @objc private func hideGuideHandler() {
    self.view.isHidden = true
    self.view.removeFromSuperview()
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    currentIndex = Int( scrollView.contentOffset.x / self.view.frame.size.width )
    pageControl.currentPage = currentIndex
  }
  
  func creatLabel(_ string: String) -> NSAttributedString {
    let attrString = NSMutableAttributedString(string: string)
    
    let strSubAttr1: [NSMutableAttributedString.Key: Any] = [.font: UIFont(name: "PingFang-SC-Semibold", size: 32) as Any,.foregroundColor: UIColor.black]
    attrString.addAttributes(strSubAttr1, range: NSRange(location: 0, length: string.count - 2))
    
    let strSubAttr2: [NSMutableAttributedString.Key: Any] = [.font: UIFont(name: "PingFang-SC-Semibold", size: 32) as Any,.foregroundColor: UIColor.red]
    attrString.addAttributes(strSubAttr2, range: NSRange(location: string.count - 2, length: 2))
    
    return attrString
  }
  
}

