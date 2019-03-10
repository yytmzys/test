//
//  TableViewController.swift
//  Swift_test
//
//  Created by yytmzys on 2018/11/30.
//  Copyright © 2018 yytmzys. All rights reserved.
//

import UIKit
import MJRefresh

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  let identifier = "identifier"
  var index = 0
  let header = MJRefreshNormalHeader()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    let tableView = UITableView(frame: .zero, style: UITableView.Style.plain)
    if #available(iOS 11.0, *)  {
      tableView.contentInsetAdjustmentBehavior = .automatic
    }
    tableView.dataSource = self
    tableView.delegate   = self
    tableView.decelerationRate = UIScrollView.DecelerationRate(rawValue: 1)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
    self.view.addSubview(tableView)
    tableView.autoPinEdgesToSuperviewEdges(with: .zero)
    
    header.setRefreshingTarget(self, refreshingAction: #selector(addMore))
    tableView.mj_header = header
    header.beginRefreshing()
    
  }
  
  @objc func addMore() {
    
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
      return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
  
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
    if cell == nil {
      cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
    }
    cell?.textLabel?.text = "\(indexPath.row)"
  
    return cell!
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    index = indexPath.row
    tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.top, animated: true)
    tableView.reloadData()
  }
  
  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destination.
      // Pass the selected object to the new view controller.
  }
  */

}
