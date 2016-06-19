//
//  CustomPopUp.swift
//  MyAnimationExercise
//
//  Created by Technique on 19/06/2016.
//  Copyright © 2016 Marine Commerçon. All rights reserved.
//

import UIKit

// MARK: Protocol

protocol CustomPopupDelegate {
    func didClickOnCross()
}

@IBDesignable class CustomPopUp: UIView {
    
   
    // The custom view from the XIB file
    var view: UIView!
    var customPopupDelegate: CustomPopupDelegate?
    
    @IBOutlet weak var popupLabel: UILabel!
    @IBOutlet weak var popupView: PopUpView!
    @IBOutlet weak var popupButton: UIButton!
    
    // MARK: Set Properties
    
    // Dynamic properties for the view
    @IBInspectable var labelText: String = "" {
        didSet {
            self.popupLabel.text = labelText
        }
    }
    
    // MARK: Init View
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // Setup for property
        
        
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
        let nib = UINib(nibName: "CustomPopUp", bundle: bundle)
        
        // AUIView is top level and the only object in nib
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    @IBAction func onClickCross(sender: AnyObject) {
        customPopupDelegate?.didClickOnCross()
        
    }
}


