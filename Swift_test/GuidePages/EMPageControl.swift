//
//  EMPageControl.swift
//  Example
//  自定义pageControl
//  Created by Illusion on 2018/6/16.
//  Copyright © 2017年 Illusion. All rights reserved.
//
import UIKit

class EMPageControl: UIView {
  let pageControlDiameter: CGFloat = 5
  let multiple: CGFloat            = 3
  var currentPage: NSInteger = 0 {
    didSet {
      if oldValue == currentPage {
        return
      }
      
      if currentPage < oldValue {// 向右拉伸
        UIView.animate(withDuration: 0.3, animations: {
          for dot in self.subviews {
            var dotFrame = dot.frame
            if dot.tag == self.currentPage {
              dotFrame.size.width = self.pageControlDiameter * self.multiple
              dot.backgroundColor = UIColor(red: 0, green: 0.88, blue: 0.66, alpha: 1)
              dot.frame = dotFrame
              
            } else if dot.tag <= oldValue && dot.tag > self.currentPage {
              dotFrame.origin.x += self.pageControlDiameter * (self.multiple - 1)
              dotFrame.size.width = self.pageControlDiameter
              dot.backgroundColor = UIColor(red: 0, green: 0.88, blue: 0.66, alpha: 0.2)
              dot.frame = dotFrame
            }
          }
        })
        
      } else {// 向左拉伸
        UIView.animate(withDuration: 0.3, animations: {
          for dot in self.subviews {
            var dotFrame = dot.frame
            if dot.tag == self.currentPage {
              dotFrame.size.width = self.pageControlDiameter * self.multiple
              dotFrame.origin.x -= self.pageControlDiameter * (self.multiple - 1)
              dot.backgroundColor = UIColor(red: 0, green: 0.88, blue: 0.66, alpha: 1)
              dot.frame = dotFrame
              
            } else if dot.tag > oldValue && dot.tag < self.currentPage {
              dotFrame.origin.x -= self.pageControlDiameter
              dot.frame = dotFrame
              
            } else if dot.tag == oldValue {
              dotFrame.size.width = self.pageControlDiameter
              dot.backgroundColor = UIColor(red: 0, green: 0.88, blue: 0.66, alpha: 0.2)
              dot.frame = dotFrame
            }
          }
        })
        
      }
      
    }
  }
  
  
  var numberOfPages: NSInteger = 0 {
    didSet {
      if self.numberOfPages == 0 {
        return
      }
      if self.subviews.count > 0 {
        for view in self.subviews {
          view.removeFromSuperview()
        }
      }
      
      var dotX: CGFloat = 0;
      var dotW: CGFloat = pageControlDiameter;
      var bgColor: UIColor
      for i in 0..<numberOfPages {
        if i <= currentPage {
          dotX = 0
        } else {
          dotX = pageControlDiameter * (multiple + 1) + pageControlDiameter * 2 * CGFloat(i - 1)
        }// *** * * *
        
        if i == currentPage {
          dotW = pageControlDiameter * multiple;
          bgColor = UIColor(red: 0, green: 0.88, blue: 0.66, alpha: 1)
        } else {
          dotW = pageControlDiameter;
          bgColor = UIColor(red: 0, green: 0.88, blue: 0.66, alpha: 0.2)
        }
        
        let temp = UIView()
        temp.frame = CGRect(x: dotX, y: 0, width: dotW, height: pageControlDiameter)
        temp.layer.cornerRadius = pageControlDiameter * 0.5
        temp.layer.masksToBounds = true
        temp.backgroundColor = bgColor
        temp.tag = i
        addSubview(temp)
      }
      
    }
  }
  
}
