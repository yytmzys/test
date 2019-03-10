//
//  MusicianSongVC.swift
//  Swift_test
//
//  Created by yytmzys on 2018/12/19.
//  Copyright © 2018 yytmzys. All rights reserved.
//

import UIKit

class MusicianSongVC: UIViewController , UITableViewDataSource, UITableViewDelegate{
  
  var scrollViewDidScrollHandler:((_ scrollView: UIScrollView, _ previousContentOffSet : CGPoint)->())?
  
  fileprivate var isCanRoll = true
  fileprivate let tableView = UITableView(frame: .zero)
  fileprivate let identifier = "UITableViewCell"
  fileprivate var previousContentOffSet: CGPoint = .zero
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.view.backgroundColor = .white
    
    if #available(iOS 11.0, *)  {
      tableView.contentInsetAdjustmentBehavior = .never
    }
    
    tableView.dataSource = self;
    tableView.delegate   = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
    self.view.addSubview(tableView)
    tableView.autoPinEdgesToSuperviewEdges()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 30
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
    if cell == nil {
      cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
    }
    cell?.textLabel?.text = "秘密的爱\(indexPath.row)"
    return cell!
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
