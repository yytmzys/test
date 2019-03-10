//
//  MusicianViewController.swift
//  Swift_test
//
//  Created by yytmzys on 2019/1/13.
//  Copyright © 2019 yytmzys. All rights reserved.
//

import UIKit


fileprivate let headerViewHeight: CGFloat = 200
let IS_IPHONE_X =  (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1125, height: 2436).equalTo((UIScreen.main.currentMode?.size)!) : false)


class MusicianViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , UIScrollViewDelegate{
  
  fileprivate let tableView  = UITableView(frame: .zero, style: .plain)
  fileprivate let identifier = "UITableViewCell"
  fileprivate let containerView = UIView(frame: .zero)
  fileprivate let segMentView = MusicianSegmentView(frame: .zero)
  
  override func viewDidLoad() {
    self.view.backgroundColor = .white
    let width = self.view.bounds.size.width
    let height = self.view.bounds.size.height
    
    self.navigationController?.navigationBar.alpha = 0
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.delegate   = self
    self.view.addSubview(tableView)
    tableView.autoPinEdgesToSuperviewEdges()
    
    
    let headerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 200))
    tableView.tableHeaderView = headerView
    tableView.backgroundColor = .red
    
    
    containerView.addSubview(segMentView)
    segMentView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
    segMentView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
    segMentView.autoSetDimension(.height, toSize: 60)
    segMentView.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
    
    
    let songVC  = MusicianSongVC()
    let albumVC = MusicianAlbumVC()
    let artistsVC = MusicianSimilarArtistsVC()
    let introductionVC = MusicianIntroductionVC()
    
    let VCs = [songVC, albumVC, artistsVC, introductionVC]
    let containerVC = ZFSlideSegmentController(VCs, startIndex: 0)
    
    self.addChild(containerVC)
    containerVC.view.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(containerVC.view)
    containerVC.view.autoPinEdgesToSuperviewEdges(with:UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0))
    containerVC.didMove(toParent: self)
    
    
    containerVC.didScrollingHandler = {
      [weak self] (slideVC, slideView, direction) in
      guard let `self` = self else { return }
      let progress = slideView.contentOffset.x / slideView.bounds.size.width
      self.segMentView.segment.configure(progress: progress)
    }
    segMentView.segment.selectedIndexChangedHandler = {
      [weak self] () in
      guard let `self` = self else { return }
      let index = self.segMentView.segment.selectedIndex
      containerVC.setSelectedIndex(index, animated: false)
    }
  }
  
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let currentOffsetY = scrollView.contentOffset.y
    let height = 0 - navHeight()
//    print("\(height), currentOffsetY =\(currentOffsetY)")
//    if currentOffsetY < height {
//
//    } else {
//      tableView.contentOffset.y = height
//    }
  }
  
  
  func navHeight() -> CGFloat {
    
    //导航栏高度也可以根据UINavigationController动态获取
    var navh: CGFloat = 44.0
    
    if #available(iOS 12.0, *) {
      navh += CGFloat((UIApplication.shared.delegate?.window?!.safeAreaInsets.top)!)
    }else if IS_IPHONE_X {
      navh += CGFloat((UIApplication.shared.delegate?.window?!.safeAreaInsets.top)!)
    }else{
      navh += CGFloat(UIApplication.shared.statusBarFrame.size.height)
    }
    return navh
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return tableView.bounds.height
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
    if cell == nil {
      cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
    }
    cell?.contentView.addSubview(containerView)
    containerView.autoPinEdgesToSuperviewEdges()
    
    
    return cell!
  }
  
}
