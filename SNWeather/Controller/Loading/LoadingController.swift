//
//  LoadingController.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 05/07/22.
//

import Cocoa

class LoadingController: NSViewController {
    @IBOutlet weak var inderterminateProgressBar: NSProgressIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inderterminateProgressBar.startAnimation(self)
        fetchSuccess()
    }
    
    
    func fetchSuccess() {
        CoreDataHelper.start(onSuccess: {
            CoreDataHelper.mock()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.animateStart()
            }
        }, onError: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.animateStart()
            }
        })
    }
    
    func animateStart() {
        self.inderterminateProgressBar.stopAnimation(self)
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateController(withIdentifier: "Weather") as? ViewController else { return }
        self.present(controller, animator: MyTransitionAnimator())
    }
}

class MyTransitionAnimator: NSObject, NSViewControllerPresentationAnimator {
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        let bottomVC = fromViewController
        let topVC = viewController
        topVC.view.wantsLayer = true
        topVC.view.layerContentsRedrawPolicy = .onSetNeedsDisplay
        topVC.view.alphaValue = 0
        bottomVC.view.addSubview(topVC.view)
        topVC.view.frame = bottomVC.view.frame
        NSAnimationContext.runAnimationGroup({ (context) -> Void in
            context.duration = 0.35
            topVC.view.animator().alphaValue = 1
            
        }, completionHandler: nil)
    }
    
    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        let bottomVC = fromViewController
        let topVC = viewController
        topVC.view.wantsLayer = true
        topVC.view.layerContentsRedrawPolicy = .onSetNeedsDisplay
        NSAnimationContext.runAnimationGroup({ (context) -> Void in
            context.duration = 0.35
            topVC.view.animator().alphaValue = 0
        }, completionHandler: {
            topVC.view.removeFromSuperview()
        })
    }
}
