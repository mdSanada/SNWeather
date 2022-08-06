//
//  LoadingController.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 05/07/22.
//

import Cocoa

class LoadingController: NSViewController {
    @IBOutlet weak var inderterminateProgressBar: NSProgressIndicator!
    internal let weatherManager = ACNetworkManager<WeatherService>()

    override func viewDidLoad() {
        super.viewDidLoad()
        inderterminateProgressBar.startAnimation(self)
        fetchSuccess()
    }
    
    func fetchSuccess() {
        CoreDataHelper.start(onSuccess: {
            self.fetchAllWeathers { weathers in
                self.animateStart(weathers: weathers)
            }
        }, onError: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.animateStart(weathers: [])
            }
        })
    }
    
    func fetchAllWeathers(completed: @escaping (([WeatherDTO]) -> ())) {
        DispatchQueue.main.async {
            var weathers = self.getFavoritesWeathers()
            var allSuccess: [Bool?] = weathers.map { _ in false } {
                didSet {
                    if allSuccess.compactMap({ $0 }).allSatisfy({ $0 }) {
                        completed(weathers)
                    }
                }
            }
            for (index, weather) in weathers.enumerated() {
                sleep(1)
                self.weatherManager.request(.weather(lat: weather.lat, lon: weather.lon),
                                       map: WeatherModel.self,
                                       onLoading: { loading in
                    print("Loading: \(loading)")
                }, onSuccess: { weather in
                    print(weather)
                    weathers[(index)].details = weather
                    allSuccess[index] = true
                }, onError: { error in
                    weathers.remove(at: index)
                    allSuccess[index] = true
                }, onMapError: { data in
                    weathers.remove(at: index)
                    allSuccess[index] = true
                })
            }

        }
    }
    
    func animateStart(weathers: [WeatherDTO]) {
        DispatchQueue.main.async {
            self.inderterminateProgressBar.stopAnimation(self)
            let storyboard = NSStoryboard(name: "Main", bundle: nil)
            guard let controller = storyboard.instantiateController(withIdentifier: "Weather") as? ViewController else { return }
            controller.initialWeathers = weathers
            self.present(controller, animator: MyTransitionAnimator())
        }
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
