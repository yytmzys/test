//
//  MyOfflineViewController.swift
//  Swift_test
//
//  Created by yytmzys on 2018/12/5.
//  Copyright © 2018 yytmzys. All rights reserved.
//

import UIKit
import PureLayout

enum MyOfflineIndexPathType {
  case header
  case songlist
  case album
  case channel
}

class MyOfflineSourceConfig: NSObject {
  var register: ((UITableView)->())?
  var getHeight: ((IndexPath)->(CGFloat))?
  var getNumberOfRows: (()->(Int))?
  var displayCell: ((UITableView, IndexPath)->(UITableViewCell?))?
}


class MyOfflineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  let idMyOfflineHeaderCell = "MyOfflineHeaderCell"
  let idOfflineSongListCell = "OfflineSongListCell"
  let idOfflineSongListMoreCell = "OfflineSongListMoreCell"
  let idOfflineSongRecordCell = "OfflineSongRecordCell"
  let idMyOfflineFooterCell   = "MyOfflineFooterCell"
  
  let offlineSongListArray:Array! = ["降E大调曲-肖邦", "降D大调曲-肖邦", "降C大调曲-肖邦", "降B大调曲-肖邦"]
  let offlinerecordArray:Array!   = ["未来日记", "降E大调曲-肖邦", "青衣谣"]
  var tableView: UITableView! = nil
  
  var configs: [MyOfflineSourceConfig] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.white
    
    // header
    let headerConfig = MyOfflineSourceConfig()
    headerConfig.register = {
      (tableView) in
      tableView.register(MyOfflineHeaderCell.self, forCellReuseIdentifier: self.idMyOfflineHeaderCell)
    }
    headerConfig.getHeight = {
      (indexPath) in
      return 204
    }
    headerConfig.getNumberOfRows = {
      return 1
    }
    headerConfig.displayCell = {
      (tableView, indexPath) in
      guard let cell = tableView.dequeueReusableCell(withIdentifier: self.idMyOfflineHeaderCell, for: indexPath) as? MyOfflineHeaderCell else { return nil }
      cell.selectionStyle = .none
      cell.backgroundColor = .clear
      cell.configure()
      cell.pushSongHandler = {
        (index) in
        print("push\(index)")
      }
      
      cell.playSongHandler = {
        (index) in
        print("play\(index)")
      }
      
      return cell
    }
    
    // songlist
    let songlistConfig = MyOfflineSourceConfig()
    songlistConfig.register = {
      (tableView) in
      tableView.register(OfflineSongListCell.self, forCellReuseIdentifier: self.idOfflineSongListCell)
    }
    
    songlistConfig.getHeight = {
      (indexPath) in
      var height: CGFloat = 0
      
      if self.offlineSongListArray.count > 0 {
        height += 101
        
        let maxCount = min(self.offlineSongListArray.count, 3)
        height += CGFloat(maxCount * 60 + (maxCount - 1) * 20)
      }
      
      if self.offlineSongListArray.count > 3 {
        height += 35 + 30
      }
      
      return height
    }
    
    songlistConfig.getNumberOfRows = {
      if self.offlineSongListArray.count > 0 {
        return 1
      }
      return 0
    }
    
    songlistConfig.displayCell = {
      (tableView, indexPath) in
      let cell = tableView.dequeueReusableCell(withIdentifier: self.idOfflineSongListCell, for: indexPath) as? OfflineSongListCell
      cell?.selectionStyle = .none
      cell?.backgroundColor = .clear
      cell?.configure(self.offlineSongListArray)
      
      return cell
    }
    
    // album
    let recordConfig = MyOfflineSourceConfig()
    recordConfig.register = {
      (tableView) in
      tableView.register(OfflineSongRecordCell.self, forCellReuseIdentifier: self.idOfflineSongRecordCell)
    }
    
    recordConfig.getHeight = {
      (indexPath) in
      return 101 + (UIScreen.main.bounds.size.width - 67) / 2 + 63
    }
    
    recordConfig.getNumberOfRows = {
      if self.offlinerecordArray.count > 0 {
        return 1
      }
      return 0
    }
    
    recordConfig.displayCell = {
      (tableView, indexPath) in
      guard let cell = tableView.dequeueReusableCell(withIdentifier: self.idOfflineSongRecordCell, for: indexPath) as? OfflineSongRecordCell else { return nil }
      cell.selectionStyle = .none
      cell.backgroundColor = .clear
      
      cell.configure(songRecordArray: self.offlinerecordArray)
      
      cell.moreHandler = {
        print("设置")
      }
      cell.recordImageHandler = {
        (index) in
        print("push\(index)")
      }
      cell.recordPalyHandler = {
        (index) in
        print("play\(index)")
      }
      
      return cell
    }
    
    // private
    let footerConfig = MyOfflineSourceConfig()
    footerConfig.register = {
      (tableView) in
      tableView.register(MyOfflineFooterCell.self, forCellReuseIdentifier: self.idMyOfflineFooterCell)
    }
    
    footerConfig.getHeight = {
      (indexPath) in      
      return 234
    }
    
    footerConfig.getNumberOfRows = {
      return 1
    }
    
    footerConfig.displayCell = {
      (tableView, indexPath) in
      let cell = tableView.dequeueReusableCell(withIdentifier: self.idMyOfflineFooterCell, for: indexPath) as? MyOfflineFooterCell
      cell?.selectionStyle = .none
      cell?.backgroundColor = .clear
      cell?.chanalHandler = {
        print("离线兆赫")
      }
      cell?.setupHandler = {
        print("设置")
      }
      return cell
    }
    
    configs.append(headerConfig)
    configs.append(songlistConfig)
    configs.append(recordConfig)
    configs.append(footerConfig)
    
    tableView = UITableView(frame: .zero, style: .plain)
    tableView.backgroundColor = .white
    tableView.dataSource = self
    tableView.delegate   = self
    
    for config in configs {
      if let handler = config.register {
        handler(tableView)
      }
    }
    
    tableView.separatorStyle = .none
    self.view.addSubview(tableView)
    tableView.autoPinEdgesToSuperviewEdges()
  }
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return configs.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let config = configs[section]
    if let handler = config.getNumberOfRows {
      return handler()
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let config = configs[indexPath.section]
    if let handler = config.getHeight {
      return handler(indexPath)
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let config = configs[indexPath.section]
    if let handler = config.displayCell {
      if let cell = handler(tableView, indexPath) {
        return cell
      }
    }
    assert(false, "should not be hear")
    return tableView.dequeueReusableCell(withIdentifier: "placeholder", for: indexPath)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 1 {
      if indexPath.row > 0 && indexPath.row < 4 {
        print("肖邦")
      }
    }
  }
  
}
