//
//  SliderViewController.swift
//  Swift_test
//
//  Created by yytmzys on 2019/1/28.
//  Copyright © 2019 yytmzys. All rights reserved.
//

import Foundation
import PureLayout

enum SliderStatusType {
  case stop
  case moving
}

class SliderViewController: UIViewController {

  let redView = UIView(frame: .zero)
  let redView2 = UIView(frame: .zero)
  var isCanMove: Bool = true
  var time: CGFloat  = 0
  var width: CGFloat = 0
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = UIColor.white
    
    redView.frame = CGRect(x: 0, y: 200, width: 0, height: 10)
    redView.backgroundColor = .red
    self.view.addSubview(redView)
    
    redView2.frame = CGRect(x: 0, y: 200, width: 0, height: 10)
    redView2.backgroundColor = .red
    self.view.addSubview(redView2)
    
    
    let startButton = UIButton(frame: CGRect(x: 25, y: 100, width: 50, height: 30))
    startButton.setTitle("开始", for: .normal)
    startButton.setTitleColor(.red, for: .normal)
    startButton.addTarget(self, action: #selector(start), for: .touchUpInside)
    self.view.addSubview(startButton)
    
    let stopButton = UIButton(frame: CGRect(x: 150, y: 100, width: 50, height: 30))
    stopButton.setTitle("停止", for: .normal)
    stopButton.setTitleColor(.red, for: .normal)
    stopButton.addTarget(self, action: #selector(stop), for: .touchUpInside)
    self.view.addSubview(stopButton)
    
    time  = 180 / self.view.frame.size.width
    
//    let slider = UISlider(frame: .zero)
//    slider.minimumTrackTintColor = UIColor.darkGray
//    slider.maximumTrackTintColor = UIColor.orange
//    slider.minimumValue = 0
//    slider.maximumValue = 180
//    slider.value = 20
//    self.view.addSubview(slider)
//    slider.autoPinEdge(toSuperviewEdge: .top, withInset: 200)
//    slider.autoPinEdge(toSuperviewEdge: .left, withInset: 30)
//    slider.autoPinEdge(toSuperviewEdge: .right, withInset: 30)
    
//    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
//      slider.value += 1
//    }
    
    self.move()
  }
  
  @objc func start() {
//    if isMoving == false {
//      isMoving = true
//      let animation = CABasicAnimation()
//      animation.keyPath = "bounds"
//      animation.fromValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: 0, height: 10))
//      animation.toValue   = NSValue(cgRect: CGRect(x: 0, y: 200, width: self.view.frame.size.width * 2, height: 10))
//      animation.duration  = 10
//      redView.layer.add(animation, forKey: "basic")
//    }
    
    
//    if isCanMove == true {
      width = self.view.frame.size.width / 180
      
      
//    }
    
  }
  
  func move() {
    UIView.animate(withDuration: TimeInterval(time), animations: {
      self.redView.frame = CGRect(x: 0, y: 200, width: self.redView.frame.size.width + self.width, height: 10)
    }) { (finshed) in
      self.move()
    }
  }
  
  @objc func stop() {
    width = 0
    isCanMove = false
//    self.redView.frame = CGRect(x: 0, y: 200, width: 0, height: 10)
    
//    redView.layer.removeAnimation(forKey: "basic")
//    redView.layer.removeAllAnimations()
  }
}
