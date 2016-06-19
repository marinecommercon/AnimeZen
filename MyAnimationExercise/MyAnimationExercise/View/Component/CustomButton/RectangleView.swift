//
//  RectangleView.swift
//  MyAnimationExercise
//
//  Created by Technique on 18/06/2016.
//  Copyright © 2016 Marine Commerçon. All rights reserved.
//

import UIKit

// MARK: Protocol

protocol RectangleViewDelegate {
    func didBeginRectangleAnimation()
    func didFinishRectangleAnimation()
}

@IBDesignable
class RectangleView: UIView {
    
    let rectangleLayer = CALayer()
    var rectangleViewDelegate: RectangleViewDelegate?
    
    // MARK: Init View
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    // MARK: Setup Rectangle Layer
    
    func setup() {
        rectangleLayer.backgroundColor = UIColor(red: 0/255, green: 180/255, blue: 230/255, alpha: 1.0).CGColor
        rectangleLayer.frame.size.width = 300
        rectangleLayer.frame.size.height = 45
        rectangleLayer.cornerRadius = rectangleLayer.frame.size.height/2
        layer.addSublayer(rectangleLayer)
    }
    
    // MARK: Animations
    
    func updateAnimation(){
        let offset: CGFloat = self.frame.size.width/2 - 45/2
        let oldFrame = self.rectangleLayer.frame
        let oldOrigin = oldFrame.origin
        let newOrigin = CGPoint(x: oldOrigin.x + offset, y: oldOrigin.y)
        let newSize = CGSize(width: oldFrame.width + (offset * -2.0), height: oldFrame.height)
        let fromValue = self.rectangleLayer.frame
        let toValue = CGRect(origin: newOrigin, size: newSize)
        
        let animation = CABasicAnimation(keyPath: "bounds")
        animation.delegate = self
        animation.fromValue = NSValue(CGRect: fromValue)
        animation.toValue = NSValue(CGRect: toValue)
        animation.duration = 0.4
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = false
        
        rectangleLayer.addAnimation(animation, forKey: "bounds")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if(flag){
            rectangleViewDelegate?.didFinishRectangleAnimation()
        }
    }
}
