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

class SecondViewController: UIViewController {

    var tabBar: UITabBar?
    var ratio : CGFloat = 0.0
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var constraintY: NSLayoutConstraint!

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

  
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        UIView.animateWithDuration(1.5, delay: 2.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 3.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: ({
            self.constraintY.constant = 10
            self.view.layoutIfNeeded()
            
        }), completion: nil)
       
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.constraintY.constant = 89
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



}

