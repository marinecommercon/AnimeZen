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

class SecondViewController: UIViewController, UITextFieldDelegate, CustomButtonDelegate, CustomPopupDelegate, SharePopupDelegate {

    var tabBar: UITabBar?
    var ratio : CGFloat = 0.0
    var currentTag = NSString()
    
    var textField = UITextField()
    @IBOutlet weak var shareView: UIScrollView!
    @IBOutlet weak var shareViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var shareLabelTop: NSLayoutConstraint!
    
    @IBOutlet weak var messageButton: CustomButton!
    @IBOutlet weak var whatsappButton: CustomButton!
    @IBOutlet weak var facebookButton: CustomButton!
    @IBOutlet weak var twitterButton: CustomButton!
    @IBOutlet weak var mailButton: CustomButton!
    @IBOutlet weak var moreLabel: UILabel!
    
    @IBOutlet weak var sharePopupView: SharePopUp!
    @IBOutlet weak var sharePopupBottom: NSLayoutConstraint!
    @IBOutlet weak var sharePopupTop: NSLayoutConstraint!
    
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var timeViewTop: NSLayoutConstraint!
    @IBOutlet weak var extendButton: SimpleButton!
    @IBOutlet weak var stopButton: SimpleButton!
    
    @IBOutlet weak var customPopupView: CustomPopUp!
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

  
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.shareViewTop.constant = 89
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.shareViewTop.constant = 89
        
        // Delegate Popup
        self.customPopupView.customPopupDelegate = self
        
        // Delegate Buttons
        self.messageButton.customButtonDelegate = self
        self.whatsappButton.customButtonDelegate = self
        self.facebookButton.customButtonDelegate = self
        self.twitterButton.customButtonDelegate = self
        self.mailButton.customButtonDelegate = self
        
        // Hide Time View Elements
        self.timeView.alpha = 0
        self.extendButton.alpha = 0
        self.stopButton.alpha = 0
        
        // Notifications for Keyboard
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SecondViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SecondViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        // Control Keyboard with textview
        view.addSubview(textField)
        textField.delegate = self
        
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
            self.shareViewTop.constant = 10
            self.view.layoutIfNeeded()
            
        }), completion: nil)
    }
    
    func didFinishSpinningAnimation(customTag: NSString) {
        
        // Remember the button to re-init later
        self.currentTag = customTag
        
        self.view.userInteractionEnabled = false
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: ({

            self.textField.becomeFirstResponder()
            
        }), completion: nil)
    }
    
    func didBeginSpinningAnimation() {
        //
    }
    
    func didClickOnPost() {
        
        // Hide Custom PopUp
        self.customPopupView.alpha = 0
        self.shareViewTop.constant = 10
        self.view.layoutIfNeeded()
        
        // Change label
        self.shareLabel.text = "Sharing started"
        self.shareLabelTop.constant = 0
        
        // Hide Buttons
        self.messageButton.hidden = true
        self.whatsappButton.hidden = true
        self.facebookButton.hidden = true
        self.twitterButton.hidden = true
        self.mailButton.hidden = true
        self.moreLabel.hidden = true
        
        
        self.view.userInteractionEnabled = true
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: ({
            self.textField.endEditing(true)
        }), completion: { (finished: Bool) -> Void in
            
            self.startTimeAnimation()
        })

    }
    
    func startTimeAnimation(){
        
        self.timeView.frame.origin.y = 700
        self.extendButton.frame.origin.y = 700
        self.stopButton.frame.origin.y = 700
        
        UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 15, options: .CurveEaseInOut, animations: {
            
            // Show Time View
            self.timeView.alpha = 1
            self.timeView.frame.origin.y = 252
        }) { _ in
            //
        }
        
        UIView.animateWithDuration(0.5, delay: 0.8, usingSpringWithDamping: 0.8, initialSpringVelocity: 15, options: .CurveEaseInOut, animations: {
            
            // Show Time View
            self.extendButton.alpha = 1
            self.extendButton.frame.origin.y = 344
        }) { _ in
            //
        }
        
        UIView.animateWithDuration(0.5, delay: 1.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 15, options: .CurveEaseInOut, animations: {
            
            // Show Time View
            self.stopButton.alpha = 1
            self.stopButton.frame.origin.y = 396
        }) { _ in
            //
        }

        
    
    
    }



}

