//
//  SpinningView.swift
//  MyAnimationExercise
//
//  Created by Technique on 18/06/2016.
//  Copyright © 2016 Marine Commerçon. All rights reserved.
//

import UIKit

// MARK: Protocol

protocol SpinningViewDelegate {
    func didFinishSpinningAnimation()
}

@IBDesignable
class SpinningView: UIView {
    
    let circleLayer = CAShapeLayer()
    var spinningViewDelegate: SpinningViewDelegate?
    
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
    
    // MARK: Setup Circle Layer
    
    func setup() {
        circleLayer.hidden = true
        circleLayer.lineWidth = 4
        circleLayer.fillColor = nil
        circleLayer.strokeColor = UIColor(red: 185/255, green: 249/255, blue: 21/255, alpha: 1.0).CGColor
        layer.addSublayer(circleLayer)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height)/2 - circleLayer.lineWidth/2
        
        let startAngle = CGFloat(-M_PI)
        let endAngle = startAngle + CGFloat(M_PI*4)
        let path = UIBezierPath(arcCenter: CGPointZero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        circleLayer.position = center
        circleLayer.path = path.CGPath
    }
    
    // MARK: Animations
    
    let strokeEndAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1.2
        
        let group = CAAnimationGroup()
        group.repeatCount = 1
        group.duration = 1.2
        group.animations = [animation]
        
        return group
    }()
    
    let strokeStartAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.beginTime = 0.05
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1.25
        
        let group = CAAnimationGroup()
        group.repeatCount = 1
        group.duration = 1.25
        group.animations = [animation]
        
        return group
    }()
    
    func updateAnimation() {
        
        strokeStartAnimation.delegate = self
        strokeStartAnimation.fillMode = kCAFillModeForwards;
        strokeStartAnimation.removedOnCompletion = false
        strokeEndAnimation.fillMode = kCAFillModeForwards;
        strokeEndAnimation.removedOnCompletion = false
        circleLayer.hidden = false
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.circleLayer.hidden = true
            self.spinningViewDelegate?.didFinishSpinningAnimation()
        })
        circleLayer.addAnimation(strokeEndAnimation, forKey: "strokeEnd")
        circleLayer.addAnimation(strokeStartAnimation, forKey: "strokeStart")
        CATransaction.commit()
    }
    
}