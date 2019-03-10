//
//  MusicianIntroductionVC.swift
//  Swift_test
//
//  Created by yytmzys on 2018/12/19.
//  Copyright © 2018 yytmzys. All rights reserved.
//

import UIKit

class MusicianIntroductionVC: UIViewController , UITableViewDataSource, UITableViewDelegate{
  
  let identifier = "UITableViewCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.view.backgroundColor = .white
    
    let tableView = UITableView(frame: .zero)
    tableView.dataSource = self;
    tableView.delegate   = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
    self.view.addSubview(tableView)
    tableView.autoPinEdgesToSuperviewEdges()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
    if cell == nil {
      cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
    }
    cell?.textLabel?.text = "简介"
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
