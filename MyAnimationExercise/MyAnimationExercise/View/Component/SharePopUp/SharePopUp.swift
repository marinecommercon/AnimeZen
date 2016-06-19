//
//  SharePopUp.swift
//  MyAnimationExercise
//
//  Created by Technique on 19/06/2016.
//  Copyright © 2016 Marine Commerçon. All rights reserved.
//

import UIKit

// MARK: Protocol

protocol SharePopupDelegate {
    func didClickOnPost()
}

@IBDesignable
class SharePopUp: UIView {
    
    let rectangleLayer = CALayer()
    var view: UIView!
    var sharePopupDelegate: SharePopupDelegate?
    
    // MARK: Init View
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    // MARK: Setup Rectangle Layer
    
    func updateSize(height: CGFloat){
        
        view = UIView(frame: CGRectMake(0, 0, 300, height))
        
        rectangleLayer.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0).CGColor
        rectangleLayer.frame.size.width = 300
        rectangleLayer.frame.size.height = height
        rectangleLayer.cornerRadius = 10

        let button = UIButton(frame: CGRect(x: 200, y: 5, width: 100, height: 30))
        button.setTitleColor(UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0), forState: UIControlState.Normal)
        button.setTitle("POST", forState: .Normal)
        button.titleLabel?.textAlignment = NSTextAlignment.Right
        button.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        
        view.layer.addSublayer(rectangleLayer)
        view.addSubview(button)
        addSubview(view)
    }
    
    func buttonAction(sender: UIButton!) {
        sharePopupDelegate?.didClickOnPost()
    }


    
}