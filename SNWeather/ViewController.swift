//
//  ViewController.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 23/06/22.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    @IBOutlet weak var card: UIVisualEffectView!
    var skWeather: WeatherSKView!

    override func viewDidLoad() {
        super.viewDidLoad()
        addAnimation()
    }
        
    private func addAnimation() {
        skWeather = WeatherSKView(frame: view.frame)
        skWeather.addConditions([.clouds(weight: .moderate)])
//        skWeather.removeCondition(.thunderstorm(weight: nil))
//        skWeather.removeAllConditions()
        
        view.addSubview(skWeather)
        view.bringSubviewToFront(card)
    }
}

