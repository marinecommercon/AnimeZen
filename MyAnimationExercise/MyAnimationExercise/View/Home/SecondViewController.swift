//
//  SecondViewController.swift
//  MyAnimationExercise
//
//  Created by Technique on 18/06/2016.
//  Copyright © 2016 Marine Commerçon. All rights reserved.
//

import UIKit

extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContextRef
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
        CGContextClipToMask(context, rect, self.CGImage)
        tintColor.setFill()
        CGContextFillRect(context, rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

class SecondViewController: UIViewController, CustomButtonDelegate, CustomPopupDelegate, SharePopupDelegate {

    var tabBar: UITabBar?
    var ratio : CGFloat = 0.0
    let textView = UITextView()
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var messageButton: CustomButton!
    @IBOutlet weak var whatsappButton: CustomButton!
    @IBOutlet weak var facebookButton: CustomButton!
    @IBOutlet weak var twitterButton: CustomButton!
    @IBOutlet weak var mailButton: CustomButton!
    
    @IBOutlet weak var sharePopupView: SharePopUp!
    @IBOutlet weak var sharePopupBottom: NSLayoutConstraint!
    @IBOutlet weak var sharePopupTop: NSLayoutConstraint!
    
    @IBOutlet weak var constraintY: NSLayoutConstraint!
    @IBOutlet weak var customPopupView: CustomPopUp!

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

  
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.constraintY.constant = 89
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.constraintY.constant = 89
        
        // Delegate Popup
        self.customPopupView.customPopupDelegate = self
        
        // Delegate Buttons
        self.messageButton.customButtonDelegate = self
        self.whatsappButton.customButtonDelegate = self
        self.facebookButton.customButtonDelegate = self
        self.twitterButton.customButtonDelegate = self
        self.mailButton.customButtonDelegate = self
        
        // Notifications for Keyboard
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SecondViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SecondViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        // Control Keyboard with textview
        self.view.addSubview(textView)
        
        initTabBar()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initTabBar() {
        let customPinkColor = UIColor(red: 295/255, green: 97/255, blue: 160/255, alpha: 1)
        let customGrayColor = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1)
        
        tabBar = self.tabBarController!.tabBar
        tabBar!.tintColor = customPinkColor
        
        let image = UIImage(named: "tab_back")
        tabBar!.backgroundImage = ResizeImage(image!, targetSize: tabBar!.frame.size)
        
        // To change tintColor for unselect tabs
        for item in tabBar!.items! as [UITabBarItem] {
            if let image = item.image {
                item.image = image.imageWithColor(customGrayColor).imageWithRenderingMode(.AlwaysOriginal)
            }
        }
    }
    
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        
        // Rect is a frame with the size of tab bar
        let rect = CGRectMake(0, 0, targetSize.width, targetSize.height)
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 1.0)
        
        // We draw the image in rect
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    // MARK: Keyboard
    
    func keyboardWillShow(notification: NSNotification) {
        
        self.sharePopupView.sharePopupDelegate = self
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            
            let screenHeight = UIScreen.mainScreen().bounds.height
            let statusbarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
            
            let height = screenHeight - keyboardSize.height - statusbarHeight - 15
            self.sharePopupView.updateSize(height)
            
            self.sharePopupBottom.constant = keyboardSize.height - self.tabBar!.frame.height + 5
            self.sharePopupTop.constant = 10
            self.view.layoutIfNeeded()
        }
        self.view.userInteractionEnabled = true
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()) != nil {
            self.sharePopupBottom.constant = -200
            self.sharePopupTop.constant = 700
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: CustomPopupDelegate + CustomButtonDelegate
    
    func didClickOnCross() {
        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: ({
            
            self.customPopupView.alpha = 0
            self.constraintY.constant = 10
            self.view.layoutIfNeeded()
            
        }), completion: nil)
    }
    
    func didFinishSpinningAnimation() {
        self.view.userInteractionEnabled = false
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: ({

            self.textView.becomeFirstResponder()
            
        }), completion: nil)
    }
    
    func didBeginSpinningAnimation() {
        //
    }
    
    func didClickOnPost() {
        self.view.userInteractionEnabled = true
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: ({
            
            self.textView.endEditing(true)
            
        }), completion: nil)

    }



}

