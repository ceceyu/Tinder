//
//  CardsViewController.swift
//  Tinder
//
//  Created by Cece Yu on 6/4/15.
//  Copyright (c) 2015 Cece Yu. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet weak var ryanView: UIImageView!
    var cardInitialCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardInitialCenter = ryanView.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func onPan(panGesture: UIPanGestureRecognizer) {
        
        var translation = panGesture.translationInView(view)
        
        switch panGesture.state {
        case UIGestureRecognizerState.Began:
            cardInitialCenter = ryanView.center
        case UIGestureRecognizerState.Changed:
            
            let location = panGesture.locationInView(ryanView)
            let rotationRate = CGFloat(0.005)
            
            if translation.x > 0 {
                ryanView.transform = CGAffineTransformRotate(ryanView.transform, (location.y > ryanView.bounds.size.height / 2 ? -rotationRate : rotationRate))
            } else if translation.x < 0 {
                ryanView.transform = CGAffineTransformRotate(ryanView.transform, (location.y > ryanView.bounds.size.height / 2 ? rotationRate : -rotationRate))
            }
            
            ryanView.center.x = cardInitialCenter.x + panGesture.translationInView(view).x
            
        case UIGestureRecognizerState.Ended:
            if translation.x > 50 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.ryanView.center.x = 600
                })
            }
            else if translation.x < -50 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.ryanView.center.x = -600
                })
            }
            else {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.ryanView.center = self.cardInitialCenter
                    self.ryanView.transform = CGAffineTransformMakeRotation(0)
                })
            }
        default:
            println("default case")
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        var destinationViewController = segue.destinationViewController as! ProfileViewController
        destinationViewController.image = self.ryanView.image
        
    }

    
}
