//
//  MyOfflineFooterCell.swift
//  Swift_test
//
//  Created by yytmzys on 2018/12/6.
//  Copyright © 2018 yytmzys. All rights reserved.
//

import UIKit

class MyOfflineFooterCell: UITableViewCell {

  var chanalHandler:(()->())?
  var setupHandler:( ()->() )?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }
  
}


fileprivate extension MyOfflineFooterCell {
  
  func setup() {
    
    let titleView = OfflineTitleView(frame: .zero)
    titleView.configure(title: "离线兆赫")
    titleView.configure(buttonTitle: "设置")
    titleView.rightHandler = {
      if let handler = self.setupHandler {
        handler()
      }
    }
    self.addSubview(titleView)
    titleView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
    titleView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
    titleView.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
    titleView.autoSetDimension(.height, toSize: 101)
    
    
    let containerView = UIControl(frame: .zero)
    containerView.backgroundColor = UIColor.white
    containerView.layer.shadowColor = UIColor.red.cgColor // #C3C3C3
    containerView.layer.shadowOffset = CGSize(width: 0, height: 5)
    containerView.layer.shadowOpacity = 1
    containerView.layer.shadowRadius = 17
    containerView.layer.cornerRadius = 4
    containerView.addTarget(self, action: #selector(footerHandler), for: .touchUpInside)
    self.addSubview(containerView)
    
    containerView.autoPinEdge(toSuperviewEdge: .left, withInset: 25)
    containerView.autoPinEdge(.top, to: .bottom, of: titleView, withOffset: 0)
    containerView.autoPinEdge(toSuperviewEdge: .right, withInset: 25)
    containerView.autoSetDimension(.height, toSize: 80)
  }
  
  @objc func footerHandler() {
    if let handler = chanalHandler {
      handler()
    }
  }
  
}
