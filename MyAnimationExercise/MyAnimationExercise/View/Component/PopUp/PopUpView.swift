//
//  PopUpView.swift
//  MyAnimationExercise
//
//  Created by Technique on 18/06/2016.
//  Copyright © 2016 Marine Commerçon. All rights reserved.
//

import UIKit

@IBDesignable class PopUpView: UIView {
    
    let popupLayer = CALayer()

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
    
    // MARK: Setup PopUp Layer
    
    func setup() {
        popupLayer.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0).CGColor
        popupLayer.frame.size.width = 300
        popupLayer.frame.size.height = 66
        popupLayer.cornerRadius = 10
        layer.addSublayer(popupLayer)
    }
}
