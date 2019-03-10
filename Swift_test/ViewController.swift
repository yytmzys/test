//
//  ViewController.swift
//  Swift_test
//
//  Created by yytmzys on 2018/11/26.
//  Copyright © 2018 yytmzys. All rights reserved.
//

import UIKit
import PureLayout

class ViewController: UIViewController {

    
    let scrollView = UIScrollView(frame: .zero)
    let songListV = DOUSonglistHeaderView(frame: .zero)
    
    var songlistHeaderPopupView = DOUSonglistHeaderPopupView(frame: .zero)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
      
      self.navigationController?.present(MusicianViewController(), animated: true, completion: nil)
//        scrollView.contentSize = CGSize(width: 0, height: 1000)
//        scrollView.backgroundColor = UIColor.lightGray
//        self.view.addSubview(scrollView)
//        scrollView.autoPinEdgesToSuperviewEdges()
//
//
//        songListV.songImageViewTapHander = {
//            let height = self.songListV.convert(self.songListV.songListImageView.frame.origin, from: self.view).y
//            self.songlistHeaderPopupView.songImageViewGoAnimation(height: height)
//        }
//        songListV.backgroundColor = UIColor.red
//        scrollView.addSubview(songListV)
//        songListV.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
//        songListV.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
//        songListV.autoSetDimensions(to: CGSize(width: self.view.frame.size.width, height: 260))
//
//        self.view.addSubview(songlistHeaderPopupView)
//        songlistHeaderPopupView.autoPinEdgesToSuperviewEdges(with: .zero)
        
        
        let imageView = UIImageView(frame: CGRect(x: (self.view.frame.size.width-300) / 2, y: 100, width: 300, height: 100))
//        imageView.image = UIImage(named: "0000.png")
        imageView.backgroundColor = UIColor.lightGray
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius  = 4
        self.view.addSubview(imageView)
        
//        imageView.layer.shadowColor  = UIColor.red.cgColor
//        imageView.layer.shadowOffset = CGSize(width: 0, height: -1) // 默认 0, -3
//        imageView.layer.shadowRadius  = 10
//        imageView.layer.shadowOpacity = 1
        
        /// 创建CAGradientLayer对象并设置参数 ok
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = imageView.bounds
        gradientLayer.masksToBounds = true
        gradientLayer.cornerRadius  = 5
        let gradientColors = [UIColor.red.cgColor, UIColor.green.cgColor]
        gradientLayer.colors = gradientColors
//        let gradientLocations:[NSNumber] = [0.0, 1.0]  // //定义每种颜色所在的位置
//        gradientLayer.locations = gradientLocations
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint   = CGPoint(x: 1, y: 1)
//        imageView.layer.addSublayer(gradientLayer)
//        imageView.layer.insertSublayer(gradientLayer, at: 0)
        
        
        // layer 转 图片 ok
        let context = CIContext(options: nil)
//        let originalImage = self.getImageFromView(view: imageView)
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let originalImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        /// 获取原始图片  ok
        let inputImage =  CIImage(image: originalImage)
        //使用高斯模糊滤镜
        let filter = CIFilter(name: "CIGaussianBlur")!
        filter.setValue(inputImage, forKey:kCIInputImageKey)
        //设置模糊半径值（越大越模糊）
        filter.setValue(40, forKey: kCIInputRadiusKey)
        let outputCIImage = filter.outputImage!
        let rect = CGRect(origin: CGPoint.zero, size: originalImage.size)
        let cgImage = context.createCGImage(outputCIImage, from: rect)
        imageView.image = UIImage(cgImage: cgImage!)
    }

    /// view 转换成图片
    func getImageFromView(view:UIView) ->UIImage {
        
        UIGraphicsBeginImageContext(view.bounds.size)
        
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
        
    }
    
    ///
    
    /// 生成纯色图
    func imageWithColor(color:UIColor) -> UIImage
    {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor);
        context.fill(rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}

