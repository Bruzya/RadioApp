//
//  FadeTransitionAnimator.swift
//  RadioApp
//
//  Created by dsm 5e on 03.08.2024.
//

import UIKit

class FadeTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
              let toViewController = transitionContext.viewController(forKey: .to) else {
            return
        }

        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toViewController.view.alpha = 1
            fromViewController.view.alpha = 0
        }) { _ in
            fromViewController.view.alpha = 1
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

extension ContainerVC: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeTransitionAnimator()
    }
}
