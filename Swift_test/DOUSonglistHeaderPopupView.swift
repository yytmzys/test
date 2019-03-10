//
//  DOUSonglistHeaderPopupView.swift
//  Swift_test
//
//  Created by yytmzys on 2018/11/26.
//  Copyright © 2018 yytmzys. All rights reserved.
//

import UIKit
import PureLayout

class DOUSonglistHeaderPopupView: UIView {

    var animationHandler: (()->())?

    fileprivate var isMove = true
    fileprivate var yChange: CGFloat = 0
    fileprivate let songListImageViewBackV  = UIImageView(frame: .zero)
    fileprivate var songListImageView = UIImageView(frame: .zero)
    fileprivate let songListnameLabel = UILabel(frame: .zero)
    fileprivate let detailLabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)            
        
        self.setup()
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc public func songImageViewGoAnimation(height: CGFloat) {
        
        if isMove == true {
            
            self.yChange = height
            self.isHidden = false
            
            self.songListImageView.frame = CGRect(x: 25, y: 51 - self.yChange, width: 120, height: 120)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.songListImageView.frame = CGRect(x: (self.frame.size.width - 230 ) / 2, y: 74, width: 230, height: 230)
                self.songListImageViewBackV.alpha = 1
                self.songListImageView.alpha      = 1
                self.songListnameLabel.alpha = 1
                self.detailLabel.alpha = 1
            }, completion: { (isFinish) in
                self.isMove = false
            })
            
        } else {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.songListImageView.frame = CGRect(x: 25, y: 51 - self.yChange, width: 120, height: 120)
                //self.songListV.songListImageView.frame
                self.songListImageViewBackV.alpha = 0
                self.songListImageView.alpha      = 0
                self.songListnameLabel.alpha = 0
                self.detailLabel.alpha = 0
                self.yChange = 0
            }, completion: { (isFinish) in
                self.isMove = true
                self.isHidden = true
            })
        }
        
        if let handler = self.animationHandler {
            handler()
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension DOUSonglistHeaderPopupView {
    
    func configure() {
        
        songListnameLabel.text = "望向窗外的你想什么"
        detailLabel.text       = "欢迎来到这里，这里是哪里，这是一片深邃如谜的海，是你我。"
    }

}

fileprivate extension DOUSonglistHeaderPopupView {
    
    func setup() {
        
        self.backgroundColor = UIColor.clear
        
        songListImageViewBackV.backgroundColor = UIColor.white
        songListImageViewBackV.alpha = 0;
        self.addSubview(songListImageViewBackV)
        songListImageViewBackV.autoPinEdgesToSuperviewEdges()
        
        
        songListImageView.isUserInteractionEnabled = true
        let imageViewTap = UITapGestureRecognizer(target: self, action: #selector(self.songImageViewGoAnimation))
        songListImageView.addGestureRecognizer(imageViewTap)
        songListImageView.backgroundColor = UIColor.black
        songListImageView.alpha = 0
        addSubview(self.songListImageView)
        songListImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 25)
        songListImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 25)
        songListImageView.autoSetDimensions(to: CGSize(width: 120, height: 120))        
        
        songListnameLabel.text = "望向窗外的你想什么"
        songListnameLabel.textAlignment = NSTextAlignment.center
        songListnameLabel.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        songListnameLabel.textColor = UIColor.black // #333333
        songListnameLabel.numberOfLines = 0
        songListnameLabel.alpha = 0
        self.addSubview(songListnameLabel)
        songListnameLabel.autoPinEdge(toSuperviewMargin: .left, withInset: 25)
        songListnameLabel.autoPinEdge(toSuperviewMargin: .top, withInset: 256)
        songListnameLabel.autoPinEdge(toSuperviewMargin: .right, withInset: 25)
        // 67 - 51 16
        
        detailLabel.text = "每当我有网络的时候，我开始意识到我可以接着做我以前说好要做的东西了，算是对自己的交代，虽然我一直很害怕诺言，结果还是忍不住许诺，没办法，谁叫我那么爱你。"
        detailLabel.textColor = UIColor.black // #555555
        detailLabel.font = UIFont(name: "PingFangSC-Regular", size: 14)
        detailLabel.numberOfLines = 0
        detailLabel.alpha = 0
//        let paragraphStye = NSMutableParagraphStyle()
//        //调整行间距
//        paragraphStye.lineSpacing = 2.5
//        let attributeds = [NSAttributedString.Key.font:UIFont(name: "PingFangSC-Regular", size: 14),
//                                NSAttributedString.Key.paragraphStyle: paragraphStye]
//        detailLabel.attributedText = NSAttributedString(string: detailLabel.text!, attributes: attributeds as [NSAttributedString.Key : Any])
        self.addSubview(detailLabel)
        detailLabel.autoPinEdge(toSuperviewMargin: .left, withInset: 17)
        detailLabel.autoPinEdge(.top, to: .bottom, of: songListnameLabel, withOffset: 30)
        detailLabel.autoPinEdge(toSuperviewMargin: .right, withInset: 17)
    }
    
}


