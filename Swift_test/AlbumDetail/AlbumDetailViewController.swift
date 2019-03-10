//
//  AlbumDetailViewController.swift
//  Swift_test
//
//  Created by yytmzys on 2018/12/29.
//  Copyright © 2018 yytmzys. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class AlbumDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
  
  let layout1 = UICollectionViewFlowLayout()
  let layout2 = UICollectionViewFlowLayout()
  
  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = .white
    
    let contentInset = UIEdgeInsets(top: 5, left: 25, bottom: 0, right: 25)
    
    layout1.minimumInteritemSpacing = 10
    layout1.sectionInset = contentInset
    layout1.itemSize = CGSize(width: 300, height: 100)
    
    layout2.minimumInteritemSpacing = 10
    layout2.sectionInset = contentInset
    layout2.itemSize = CGSize(width: 150, height: 150)
    
    
    collectionView.setCollectionViewLayout(layout1, animated: false)
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(AlbumDetailCell.self, forCellWithReuseIdentifier: String(describing: AlbumDetailCell.self))
    collectionView.register(AlbumDetailCell2.self, forCellWithReuseIdentifier: String(describing: AlbumDetailCell2.self))
    self.view.addSubview(collectionView)
    collectionView.autoPinEdgesToSuperviewEdges()
  }
  
  func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
    let layout = UICollectionViewTransitionLayout(currentLayout: layout1, nextLayout: layout2)
    return layout
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if section == 0 {
      
      return 5
    }
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AlbumDetailCell.self), for: indexPath)
    cell.backgroundColor = UIColor.lightGray
    
    if indexPath.section == 1 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AlbumDetailCell2.self), for: indexPath)
      cell.backgroundColor = UIColor.orange
      return cell
    }
    
    return cell
  }

}
