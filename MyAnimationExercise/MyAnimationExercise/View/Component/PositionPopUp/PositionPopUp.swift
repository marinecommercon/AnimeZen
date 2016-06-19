//
//  PositionPopUp.swift
//  MyAnimationExercise
//
//  Created by Technique on 19/06/2016.
//  Copyright © 2016 Marine Commerçon. All rights reserved.
//

import UIKit

@IBDesignable class PositionPopUp: UIView {
    
    // The custom view from the XIB file
    var view: UIView!
    let rectangleLayer = CALayer()
    
    // Outlets
    @IBOutlet weak var rectangleView: UIView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var positionImageView: UIImageView!
    
    // MARK: Set Properties
    
    // Dynamic properties for the view
    @IBInspectable var infoText: String! {
        didSet {
            self.firstLabel.text = infoText
        }
    }
    
    @IBInspectable var positionText: String! {
        didSet {
            self.secondLabel.text = positionText
        }
    }
    
    @IBInspectable var imagePosition: UIImage! {
        didSet {
            self.positionImageView.image = imagePosition
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
        
        // Custom rectangleLayer
        rectangleLayer.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0).CGColor
        rectangleLayer.frame.size.width = 332
        rectangleLayer.frame.size.height = 86
        rectangleLayer.cornerRadius = 10
        rectangleView.layer.addSublayer(rectangleLayer)

        // Adding custom subview on top of the view
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "PositionPopUp", bundle: bundle)
        
        // AUIView is top level and the only object in nib
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
}
