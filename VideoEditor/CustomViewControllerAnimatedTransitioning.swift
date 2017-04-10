//
//  CustomViewControllerAnimatedTransitioning.swift
//  VideoEditor
//
//  Created by Thai Cao Ngoc on 7/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import UIKit

/**
 Custom Trasitioning Animation class
 */
class CustomViewControllerAnimatedTransitioning: NSObject{
    var shrinkedPoint: CGPoint!
    let duration = 0.5
    
    enum TransitionMode {
        case present, dismiss
    }
    var transitionMode: TransitionMode = .present
}

/**
 Conform to UIViewControllerAnimatedTransitioning to define the animation
 */
extension CustomViewControllerAnimatedTransitioning: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    // When present, we animate the presentedVC from a point to full screen
    //  When dismiss, we animate the presentedVC from full screen to a point
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        if transitionMode == .present {
            // When present
            guard let presentedView = transitionContext.view(forKey: .to) else { return }
            let originalCenter = presentedView.center
            
            presentedView.center = shrinkedPoint
            presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            containerView.addSubview(presentedView)
            
            UIView.animate(withDuration: duration, animations: { 
                presentedView.transform = CGAffineTransform.identity
                presentedView.center = originalCenter
            }) { (success) in
                transitionContext.completeTransition(success)
            }
        } else {
            // When dismiss
            guard let dismissedView = transitionContext.view(forKey: .from) else { return }
            UIView.animate(withDuration: duration, animations: {
                dismissedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                dismissedView.center = self.shrinkedPoint
            }) { (success) in
                dismissedView.removeFromSuperview()
                transitionContext.completeTransition(success)
            }

        }
    }
}
