//
//  CustomButton.swift
//  MyAnimationExercise
//
//  Created by Technique on 18/06/2016.
//  Copyright © 2016 Marine Commerçon. All rights reserved.
//

import UIKit

// MARK: Protocol

protocol CustomButtonDelegate {
    func didBeginSpinningAnimation()
    func didFinishSpinningAnimation()
}

@IBDesignable class CustomButton: UIView, SpinningViewDelegate {
    
    // The custom view from the XIB file
    var view: UIView!
    var customButtonDelegate: CustomButtonDelegate?
    
    // Outlets
    @IBOutlet weak var rectangleView: RectangleView!
    @IBOutlet weak var spinningView: SpinningView!
    
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var shareImageView: UIImageView!
    @IBOutlet weak var shareLabel: UILabel!
    
    // MARK: Set Properties
    
    // Dynamic properties for the view
    @IBInspectable var labelText: String! {
        didSet {
            self.shareLabel.text = labelText
        }
    }
    
    @IBInspectable var imageSource: UIImage! {
        didSet {
            self.shareImageView.image = imageSource
        }
    }
    
    // MARK: Init View
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // Call super.init(coder:)
        super.init(coder: aDecoder)
        
        // Setup view from .xib file
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // Use of bounds not frame
        view.frame = bounds
        
        // The view must stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
        // Adding custom subview on top of the view
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "CustomButton", bundle: bundle)
        
        // AUIView is top level and the only object in nib
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    // MARK: Handle Touches Gesture
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touches.first != nil {
            
            self.rectangleView.updateAnimation()
            self.spinningView.spinningViewDelegate = self
            
            UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                self.shareView.alpha = 0
                }, completion: { (finished: Bool) -> Void in
                    self.spinningView.updateAnimation()
            })
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touches.first != nil {
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touches.first != nil {
        }
    }
    
    func didBeginSpinningAnimation() {
        self.customButtonDelegate?.didBeginSpinningAnimation()
    }
    
    func didFinishSpinningAnimation() {
        self.customButtonDelegate?.didFinishSpinningAnimation()
    }
}


