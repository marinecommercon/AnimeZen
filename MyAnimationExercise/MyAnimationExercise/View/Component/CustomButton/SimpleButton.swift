//
//  SimpleButton.swift
//  MyAnimationExercise
//
//  Created by Technique on 19/06/2016.
//  Copyright © 2016 Marine Commerçon. All rights reserved.
//

import UIKit

@IBDesignable class SimpleButton: UIView {
    
    // The custom view from the XIB file
    var view: UIView!

    
    // Outlets
    @IBOutlet weak var simpleLabel: UILabel!
    
    // MARK: Set Properties
    
    // Dynamic properties for the view
    @IBInspectable var labelText: String! {
        didSet {
            self.simpleLabel.text = labelText
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
        let nib = UINib(nibName: "SimpleButton", bundle: bundle)
        
        // AUIView is top level and the only object in nib
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    // MARK: Handle Touches Gesture
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touches.first != nil {
        
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
}


