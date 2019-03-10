//
//  OfflineSongListMoreCell.swift
//  Swift_test
//
//  Created by yytmzys on 2018/12/6.
//  Copyright © 2018 yytmzys. All rights reserved.
//

import UIKit
import PureLayout

class OfflineSongListMoreCell: UITableViewCell {

  var moreSongListHandler:( ()->() )?
  
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

fileprivate extension OfflineSongListMoreCell {
  
  func setup() {

        
  }
  
  @objc func moreSEl() {
    
    if let handler = moreSongListHandler {
      handler()
    }
  }
  
}
